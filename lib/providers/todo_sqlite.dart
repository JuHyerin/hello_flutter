import 'dart:async';

import 'package:hello_flutter_wirh_intellij/models/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoSqlite {
  late Database db;

  Future<void> initDb() async {

    //`path` 패키지의 `join` 함수를 사용하는 것이 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법
    db = await openDatabase(join(await getDatabasesPath(), 'my_db.db'));
    await db.execute(
      'CREATE TABLE IF NOT EXIST MyTodo ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          'title TEXT,'
          'description TEXT'
      ')'
    );
  }

  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    List<Map> maps = await db.query(
        'MyTodo',
        columns: ['id', 'title', 'description']
    );
    maps.forEach((map) => todos.add(Todo.fromMap(map)));
    return todos;
  }

  FutureOr<Todo?> getTodo(int id) async {
    List<Map> map = await db.query(
      'MyTodo',
      columns: ['id', 'title', 'description'],
      where: 'id = ?',
      whereArgs: [id]
    );
    if (map.isNotEmpty) {
      return Todo.fromMap(map[0]);
    }
    return null;
  }

  Future<void> addTodo(Todo todo) async {
    await db.insert('MyTodo', todo.toMap());
  }

  Future<void> updateTodo (Todo todo) async {
    await db.update(
      'MyTodo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id]
    );
  }

  Future<void> deleteTodo(int id) async {
    await db.delete(
      'MyTodo',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}
