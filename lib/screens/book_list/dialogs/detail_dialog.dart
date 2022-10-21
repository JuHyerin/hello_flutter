import 'package:flutter/material.dart';
import 'package:hello_flutter_wirh_intellij/models/todo.dart';

class DetailDialog extends StatelessWidget {
  final Todo todo;

  const DetailDialog({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('할 일'),
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Text('제목: ${todo.title}'),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Text('설명: ${todo.description}'),
        )
      ],
    );
  }
}
