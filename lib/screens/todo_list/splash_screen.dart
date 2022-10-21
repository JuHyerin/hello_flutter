import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_flutter_wirh_intellij/screens/todo_list/list_screen.dart';
import 'package:hello_flutter_wirh_intellij/screens/todo_list/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  _SplashScreenState createState () => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), moveScreen);
  }

  void moveScreen() async {
    await checkLogin().then((isLogin) {
      if (isLogin) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ListScreen())
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen())
        );
      }
    });
  }

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    debugPrint('[*] isLogin : ${isLogin.toString()}');

    return isLogin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Splash Screen', style: TextStyle(fontSize: 20),),
                Text('나만의 일정 관리 : TODO 리스트 앱', style: TextStyle(fontSize: 20),)
              ],
            )
        )
    );
  }


}
