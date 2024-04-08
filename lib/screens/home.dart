import 'package:flutter/material.dart';
import 'package:to_do_app/colors.dart';
import 'package:to_do_app/screens/list_item.dart';
import 'package:to_do_app/models/taskk.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final taskList = Task.taskList();
  final _taskController = TextEditingController();
  List<Task> _foundTasks = [];

  @override
  void initState() {
    _foundTasks = taskList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  _buildSearchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30, bottom: 20),
                          child: const Text(
                            'All Tasks:',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        for (Task task in _foundTasks)
                          ListItem(
                            task: task,
                            onCheckbox: _handleTaskStatus,
                            onDelete: _deleteTask,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _taskController,
                      decoration: const InputDecoration(
                        hintText: 'Add a new task',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addTask(_taskController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: tdBlue,
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                )
              ]),
            )
          ],
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/avatar.jpeg'),
            ),
          )
        ],
      ),
    );
  }

  Container _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (text) => _runFilter(text),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(
              color: tdGrey,
            )),
      ),
    );
  }

  void _handleTaskStatus(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void _deleteTask(String id) {
    setState(() {
      taskList.removeWhere((task) => task.id == id);
    });
  }

  void _addTask(String newTaskName) {
    setState(() {
      taskList.add(Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          taskName: newTaskName));
    });
    _taskController.clear();
  }

  void _runFilter(String inputText) {
    List<Task> result = [];

    inputText.isEmpty
        ? result = taskList
        : result = taskList
            .where((task) =>
                task.taskName!.toLowerCase().contains(inputText.toLowerCase()))
            .toList();

    setState(() {
      _foundTasks = result;
    });
  }
}
