import 'package:flutter/material.dart';
import 'package:local_storage_hive/controllers/todo_controller.dart';
import 'package:local_storage_hive/models/todo.dart';

class TodoView extends StatelessWidget {
   TodoView({super.key});
  final TodoController controller = TodoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Widget'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              controller.addTodo(
                Todo(
                  title: 'Contoh Judul',
                  description: 'Contoh Deskripsi',
                ),
              );
            },
            child: const Text('Tambah Data Statis'),
          ),
          Expanded(
            child: 
              ListView.builder(
                itemCount: controller.getTodos().length,
                itemBuilder: (context, index) {
                  final todo = controller.getTodos()[index];
                  return ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                  );
                },
              ),
          ),
        ],
      )
    );
  }
}