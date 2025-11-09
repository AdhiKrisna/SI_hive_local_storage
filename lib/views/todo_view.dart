import 'package:flutter/material.dart';
import 'package:local_storage_hive/controllers/todo_controller.dart';
import 'package:local_storage_hive/models/todo.dart';
import 'package:local_storage_hive/views/add_todo_page.dart';
import 'package:local_storage_hive/views/edit_todo_page.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final TodoController controller = TodoController();
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() {
    setState(() {
      todos = controller.getTodos();
    });
  }

  Future<void> _navigateToAddPage() async {
    final newTodo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddTodoPage()),
    );
    if (newTodo != null) {
      await controller.addTodo(newTodo);
      _loadTodos();
    }
  }

  Future<void> _navigateToEditPage(int index, Todo todo) async {
    final updatedTodo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditTodoPage(todo: todo)),
    );
    if (updatedTodo != null) {
      await controller.updateTodo(index, updatedTodo);
      _loadTodos();
    }
  }

  Future<void> _deleteTodoConfirm(int index) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Todo'),
        content: const Text('Yakin mau hapus item ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              await controller.deleteTodo(index);
              Navigator.pop(context);
              _loadTodos();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPage,
        child: const Icon(Icons.add),
      ),
      body: todos.isEmpty
          ? const Center(child: Text('Belum ada todo'))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              _navigateToEditPage(index, todo),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTodoConfirm(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
