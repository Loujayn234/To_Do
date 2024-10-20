// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  // Todo item data
  final String taskName;
  final bool isCompleted;
  final Function(bool?)? onChange; // Function to handle checkbox change
  final Function(BuildContext)?
      deletFunction; // Function to handle delete button click

  TodoTile(
      {super.key,
      required this.taskName,
      required this.isCompleted,
      required this.onChange,
      required this.deletFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25.0,
        top: 25.0,
      ),

      // Container to hold the checkbox and task name.
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => deletFunction?.call(context),
              icon: Icons.delete,
              backgroundColor: const Color.fromARGB(255, 254, 111, 101),
              borderRadius: BorderRadius.circular(15),
              label: 'Delete Task',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color.fromARGB(194, 239, 234, 234),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              //checkbox
              Checkbox(
                value: isCompleted,
                onChanged: onChange,
                activeColor: const Color.fromARGB(255, 78, 42, 141),
              ),

              //Task name
              Text(
                taskName,
                style: TextStyle(
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
