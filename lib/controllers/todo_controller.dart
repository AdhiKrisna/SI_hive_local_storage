import 'package:hive/hive.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_storage_hive/models/todo.dart';

class TodoController {
  final Box<Todo> todoBox = Hive.box<Todo>('todos');
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'todo_channel', // id unik
      'Todo Notifications', // nama channel
      channelDescription: 'Notifications for todo actions',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notifDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0, // ID notifikasi (bisa random kalo mau banyak)
      title,
      body,
      notifDetails,
    );
  }

  // ======================================================
  // CRUD
  // ======================================================

  // CREATE
  Future<void> addTodo(Todo todo) async {
    await todoBox.add(todo);
    await _showNotification(
      title: 'Todo Ditambahkan',
      body: '“${todo.title}” berhasil disimpan!',
    );
  }

  // READ
  List<Todo> getTodos() {
    return todoBox.values.toList();
  }

  // UPDATE
  Future<void> updateTodo(int index, Todo updatedTodo) async {
    await todoBox.putAt(index, updatedTodo);
    await _showNotification(
      title: 'Todo Diperbarui',
      body: '“${updatedTodo.title}” berhasil diperbarui!',
    );
  }

  // DELETE
  Future<void> deleteTodo(int index) async {
    final deletedTodo = todoBox.getAt(index);
    await todoBox.deleteAt(index);
    await _showNotification(
      title: 'Todo Dihapus',
      body: deletedTodo != null
          ? '“${deletedTodo.title}” telah dihapus.'
          : 'Item telah dihapus.',
    );
  }
}
