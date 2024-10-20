// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/utilities/alert.dart';
import '../utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //hive box
  final box = Hive.box('mybox');

  //text controller
  final _controller = TextEditingController();

  //todo list
  List toDoList = [];
  //chechbox method
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //save new task method
  // Save new task method
  void saveNewTask() {
    // Check if the text is not empty
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task cannot be empty'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  //cancel method
  void onCancel() {
    Navigator.of(context).pop();
  }

  //create new task method
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: onCancel,
          );
        });
  }

  //delete task method
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 202, 234),
      appBar: AppBar(
        title: const Text(
          'To Do',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(154, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 117, 104, 161),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: toDoList.isEmpty
          ? Center(
              child: Text(
                'You Have No Tasks Yet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(137, 78, 77, 77),
                ),
              ),
            )
          : ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  taskName: toDoList[index][0],
                  isCompleted: toDoList[index][1],
                  onChange: (value) => checkBoxChanged(value, index),
                  deletFunction: (context) => deleteTask(index),
                );
              },
            ),
    );
  }
}
