
import 'package:hive/hive.dart';
part 'todo.g.dart'; //file generated adapter (kaya kasih nama file model + .g.dart)
//JANGAN LUPA generate adapter dengan command: flutter pub run build_runner build (biar part ga merah)


@HiveType(typeId: 0) //identifikasi model (1 model kayak 1 tabel)
class Todo extends HiveObject {
  @HiveField(0) //kolom ke 0 (title)
  String title;

  @HiveField(1) //kolom ke 1 (description)
  String description;

  @HiveField(2) //kolom ke 2 (isCompleted)
  bool isCompleted = false;

  Todo({required this.title, required this.description});

}