import 'package:hive/hive.dart';
import 'package:local_storage_hive/models/todo.dart';

class TodoController {
  final Box<Todo> todoBox = Hive.box<Todo>('todos');

  // CREATE
  Future<void> addTodo(Todo todo) async {
    await todoBox.add(todo);
  }

  // READ
  List<Todo> getTodos() {
    return todoBox.values.toList();
  }

  // UPDATE
  Future<void> updateTodo(int index, Todo updatedTodo) async {
    await todoBox.putAt(index, updatedTodo);
  }

  // DELETE
  Future<void> deleteTodo(int index) async {
    await todoBox.deleteAt(index);
  }
}
