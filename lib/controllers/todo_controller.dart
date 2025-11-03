import 'package:hive/hive.dart';
import 'package:local_storage_hive/models/todo.dart';

class TodoController {
    final Box<Todo> todoBox = Hive.box<Todo>('todos'); //samin kayak main

    //create
    Future<void> addTodo(Todo todo) async {
        await todoBox.add(todo);
    }

    //read
    List<Todo> getTodos() {
        return todoBox.values.toList();
    }

    //update

    //delete

    
}