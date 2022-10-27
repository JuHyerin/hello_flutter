import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter_wirh_intellij/screens/book_list/list_screen.dart';
import 'package:hello_flutter_wirh_intellij/screens/navigator_practice//first_screen.dart';
import 'package:hello_flutter_wirh_intellij/screens/navigator_practice//second_screen.dart';
import 'package:hello_flutter_wirh_intellij/screens/state_practice//counter_screen.dart';
import 'package:hello_flutter_wirh_intellij/screens/timer_app/timer_screen.dart';
import 'package:hello_flutter_wirh_intellij/screens/todo_list/news_screen.dart';
import 'package:hello_flutter_wirh_intellij/screens/todo_list/splash_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book List App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const FirstScreen(),
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => const SplashScreen(),

        '/todo/news': (BuildContext context) => NewsScreen(),

        '/timer': (BuildContext context) => TimerScreen(),

        '/book/list': (BuildContext context) => ListScreen(),
        // '/book/detail': (BuildContext context) => DetailScreen(),

        '/first': (BuildContext context) => const FirstScreen(),
        '/second': (BuildContext context) => const SecondScreen(),

        '/counter': (BuildContext context) => const CounterScreen(),
      },
    );
  }
}
