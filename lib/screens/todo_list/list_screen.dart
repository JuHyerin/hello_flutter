import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter_wirh_intellij/models/todo.dart';
import 'package:hello_flutter_wirh_intellij/providers/todo_firebase.dart';
import 'package:hello_flutter_wirh_intellij/screens/book_list/dialogs/detail_dialog.dart';

class ListScreen extends StatefulWidget {
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos = [];
  TodoFirebase todoFirebase = TodoFirebase();
  /*
  * Stream 으로 제공되기 때문에 데이터를 모두 가져왔는지 여부를 스스로 알 수 있음
  * -> isLoading 필요없음
  * Stream 으로 관리해 실시간으로 데이터의 변화가 이뤄짐
  * -> setState를 통한 todos 업데이트 과정 필요없음
  * */
  // bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      todoFirebase.initDb();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: todoFirebase.todoStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: CircularProgressIndicator(),)
            );
          } else {
            todos = todoFirebase.getTodos(snapshot);
            return Scaffold(
              appBar: AppBar(
                title: const Text('할 일 목록 앱'),
                actions: [
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/todo/news');
                      },
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
                                    todoFirebase
                                      .addTodo(Todo(title: title, description: description))
                                      .then((_) => Navigator.of(context).pop());
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
              body: ListView.separated(
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
                                                  onPressed: () async{
                                                    todoFirebase
                                                      .updateTodo(Todo(reference: todos[index].reference,title: title, description: description))
                                                      .then((_) => Navigator.of(context).pop());
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
                                                    await todoFirebase.deleteTodo(todos[index]);
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
    );
  }
}
