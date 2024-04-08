import 'package:flutter/material.dart';
import 'package:to_do_app/colors.dart';
import 'package:to_do_app/models/taskk.dart';

class ListItem extends StatelessWidget {
  final Task task;
  final onCheckbox;
  final onDelete;

  const ListItem(
      {super.key, required this.task, this.onCheckbox, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onCheckbox(task);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        tileColor: Colors.white,
        leading: Icon(
          task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          task.taskName!,
          style: TextStyle(
              fontSize: 15,
              color: tdBlack,
              decoration: task.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            onPressed: () {
              onDelete(task.id);
            },
            icon: const Icon(Icons.delete),
            iconSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
