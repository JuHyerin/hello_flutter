import 'package:hello_flutter_wirh_intellij/models/todo.dart';

class TodoDefault {
  List<Todo> dummyTodos = [
    Todo(id: 1, title: 'title1', description: 'description1'),
    Todo(id: 2, title: 'title2', description: 'description2'),
    Todo(id: 3, title: 'title3', description: 'description3'),
    Todo(id: 4, title: 'title4', description: 'description4'),
  ];

  List<Todo> getTodos() {
    return dummyTodos;
  }

  Todo getTodo(int id) {
    return dummyTodos[id];
  }

  Todo addTodo(Todo todo) {
    Todo newTodo = Todo(
        id: dummyTodos.length + 1,
        title: todo.title,
        description: todo.description
    );
    dummyTodos.add(newTodo);

    return newTodo;
  }

  void deleteTodo(int id){
    for(int i = 0; i < dummyTodos.length; i++){
      if(dummyTodos[i].id == id) {
        dummyTodos.removeAt(i);
      }
    }
  }

  void updateTodo(Todo todo) {
    for(int i = 0; i < dummyTodos.length; i++){
      if(dummyTodos[i].id == todo.id) {
        dummyTodos[i] = todo;
      }
    }
  }
}
