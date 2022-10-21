import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hello_flutter_wirh_intellij/models/todo.dart';
import 'package:hello_flutter_wirh_intellij/providers/todo_default.dart';
import 'package:hello_flutter_wirh_intellij/providers/todo_sqlite.dart';
import 'package:hello_flutter_wirh_intellij/screens/book_list/dialogs/detail_dialog.dart';

class ListScreen extends StatefulWidget {
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos = [];
  TodoDefault todoDefault = TodoDefault();
  TodoSqlite todoSqlite = TodoSqlite();
  bool isLoading = true;

  Future<void> initDb() async {
    await todoSqlite.initDb().then((_) {

    });
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        todos = todoDefault.getTodos();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 목록 앱'),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.book),
                  Text('뉴스')
                ],
              )
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                String title = '';
                String description = '';

                return AlertDialog(
                  title: const Text('할 일 추가하기'),
                  content: Container(
                      height: 200,
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {title = value;},
                            decoration: const InputDecoration(labelText: '제목'),
                          ),
                          TextField(
                            onChanged: (value) {description = value;},
                            decoration: const InputDecoration(labelText: '설명'),
                          ),
                        ],
                      )
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            todoDefault.addTodo(Todo(title: title, description: description));
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text('추가')
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('취소')
                    ),
                  ],
                );
              }
          );
        },
        child: const Text('+', style: TextStyle(fontSize: 25),)
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator(),)
        : ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(todos[index].title),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => DetailDialog(todo: todos[index])
                );
              },
              trailing: Container(
                width: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  String title = todos[index].title;
                                  String description = todos[index].description;

                                  return AlertDialog(
                                    title: const Text('할 일 수정하기'),
                                    content: Container(
                                      height: 200,
                                      child: Column(
                                        children: [
                                          TextField(
                                              onChanged: (value) {title = value;},
                                              decoration: InputDecoration(hintText: todos[index].title)
                                          ),
                                          TextField(
                                              onChanged: (value) {description = value;},
                                              decoration: InputDecoration(hintText: todos[index].description)
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              todoDefault.updateTodo(Todo(id: todos[index].id, title: title, description: description));
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text('수정')
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('취소')
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Icon(Icons.edit)
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('할 일 삭제하기'),
                                  content: Container(
                                    child: const Text('삭제하시겠습니까'),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          setState(() => todoDefault.deleteTodo(todos[index].id ?? 0));
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('삭제')
                                    ),
                                    TextButton(onPressed: Navigator.of(context).pop, child: const Text('취소'))
                                  ],
                                );
                              }
                            );
                        },
                        child: const Icon(Icons.delete)
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: todos.length
      ),
    );
  }
}
