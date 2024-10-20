import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [
    ['Task name', 'description', false, 'data&time']
  ];
  final _myBox = Hive.box('mybox');

  ToDoDataBase(); // Correctly instantiate without parameters

  void createInitialData() {
    // Correct method name
    toDoList = [];
    updateDataBase(); // Save initial data to Hive
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST") ??
        []; // Use null-coalescing operator to prevent null
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
