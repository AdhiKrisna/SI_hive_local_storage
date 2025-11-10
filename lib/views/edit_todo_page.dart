import 'package:flutter/material.dart';
import 'package:local_storage_hive/controllers/todo_controller.dart';
import 'package:local_storage_hive/models/todo.dart';

class EditTodoPage extends StatefulWidget {
  final int index;
  final Todo todo;

  const EditTodoPage({
    super.key,
    required this.todo,
    required this.index,
  });

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  final TodoController _controller = TodoController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _descController = TextEditingController(text: widget.todo.description);
  }

  Future<void> _updateTodo() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul dan deskripsi tidak boleh kosong!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final updatedTodo = Todo(title: title, description: desc);
    await _controller.updateTodo(widget.index, updatedTodo);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Todo berhasil diperbarui!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Perbarui'),
              onPressed: _updateTodo,
            ),
          ],
        ),
      ),
    );
  }
}
