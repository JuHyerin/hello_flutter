import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello_flutter_wirh_intellij/models/todo.dart';

/*
* Firebase Data System
* Collection: table
* Document: field(row)
* */
class TodoFirebase {
  late CollectionReference todosReference; // Collection 주소
  late Stream<QuerySnapshot> todoStream; // Collection 에 저장된 데이터: stream of todos

  Future<void> initDb() async {
    todosReference = FirebaseFirestore.instance.collection('todos');
    todoStream = todosReference.snapshots();
  }

  List<Todo> getTodos(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((DocumentSnapshot document) => Todo.fromSnapshot(document)) // QueryDocumentSnapshot -> DocumentSnapshot -> _Todo
        .toList();
  }

  Future<void> addTodo(Todo todo) async {
    todosReference.add(todo.toMap());
  }

  Future<void>  updateTodo(Todo todo) async {
    todo.reference?.update(todo.toMap());
  }

  Future<void> deleteTodo(Todo todo) async {
    todo.reference?.delete();
  }
}