// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_page.dart';
import 'controllers/todo_controller.dart';

void main() {
  Get.put(TodoController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// lib/models/todo.dart
class Todo {
  String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});
}

// lib/controllers/todo_controller.dart
import 'package:get/get.dart';
import '../models/todo.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  void addTodo(String title) {
    todos.add(Todo(title: title));
  }

  void toggleTodo(int index) {
    todos[index].isDone = !todos[index].isDone;
    todos.refresh();
  }

  void removeTodo(int index) {
    todos.removeAt(index);
  }
}

// lib/views/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class HomePage extends StatelessWidget {
  final TodoController todoController = Get.find();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX Todo List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      todoController.addTodo(textController.text);
                      textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: todoController.todos.length,
              itemBuilder: (context, index) {
                final todo = todoController.todos[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo.isDone,
                    onChanged: (_) => todoController.toggleTodo(index),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => todoController.removeTodo(index),
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
