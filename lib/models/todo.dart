import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  late int? id;
  late String title;
  late String description;
  late DocumentReference? reference; // Firebase 내에 저장되어 있는 문서를 가리키는 포인터

  Todo({
    this.id,
    required this.title,
    required this.description,
    this.reference,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description
    };
  }

  /*
  * Named Constructor
  * [ClassName].[ConstructorName](...args){...}
  * */
  Todo.fromMap(Map<dynamic, dynamic>? map) {
    id = map?['id'];
    title = map?['title'];
    description = map?['description'];
  }

  Todo.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    id = map['id'];
    title = map['title'];
    description = map['description'];
    reference = document.reference;
  }
}

