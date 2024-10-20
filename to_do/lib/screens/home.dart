import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/utilities/alert.dart';
import '../utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.updateDataBase();
    } else {
      db.loadData();
    }
  }

  final _controller = TextEditingController();
  final _descriptionController = TextEditingController();
//checkbox
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][2] =
          !db.toDoList[index][2]; // Use correct index for isCompleted
    });
    db.updateDataBase();
  }

  //creating new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          descriptionController: _descriptionController,
          onSave: saveNewTask,
          onCancel: onCancel,
        );
      },
    );
  }

  //saving new task
  void saveNewTask() {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task cannot be empty'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    String currentDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    setState(() {
      db.toDoList.add(
          [_controller.text, _descriptionController.text, false, currentDate]);
      _controller.clear();
      _descriptionController.clear();
    });

    db.updateDataBase(); // Move this outside of the setState
    Navigator.of(context).pop();
  }

  void onCancel() {
    Navigator.of(context).pop();
  }

  // task editing
  void editTask(int index) {
    _controller.text = db.toDoList[index][0]; // Set current task name
    _descriptionController.text =
        db.toDoList[index][1]; // Set current description

    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          descriptionController: _descriptionController,
          onSave: () => saveEditedTask(index), // Save the edited task
          onCancel: onCancel,
        );
      },
    );
  }

  // save editing
  void saveEditedTask(int index) {
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
      db.toDoList[index][0] = _controller.text; // Update task name
      db.toDoList[index][1] = _descriptionController.text; // Update description
    });

    db.updateDataBase(); // Update the database
    _controller.clear(); // Clear the task name controller
    _descriptionController.clear(); // Clear the description controller
    Navigator.of(context).pop(); // Close the dialog
  }

//deleting task
  void deleteTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  db.toDoList.removeAt(index);
                  db.updateDataBase(); // Update database after deletion
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Just close the dialog
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 104, 98, 157),
              Color.fromARGB(255, 227, 226, 245),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: AppBar(
                  title: const Text(
                    'To Do',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(221, 255, 255, 255),
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Color.fromARGB(255, 90, 87, 148),
                  elevation: 0,
                ),
              ),
            ),
            Expanded(
              child: db.toDoList.isEmpty
                  ? const Center(
                      child: Text(
                        'Add Tasks To Start To-Doing',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(137, 78, 77, 77),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: db.toDoList.length,
                      itemBuilder: (context, index) {
                        print(db.toDoList[
                            index]); // Check the contents of the current index
                        // Ensure the current task has at least 4 elements
                        if (db.toDoList[index].length < 4) {
                          return const SizedBox
                              .shrink(); // Handle invalid task structure
                        }
                        return TodoTile(
                          taskName: db.toDoList[index][0],
                          taskDescription: db.toDoList[index][1],
                          isCompleted: db.toDoList[index][2],
                          taskDate: db.toDoList[index][3],
                          onChange: (value) => checkBoxChanged(value, index),
                          deletFunction: (context) => deleteTask(index),
                          editFunction: (context) => editTask(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
