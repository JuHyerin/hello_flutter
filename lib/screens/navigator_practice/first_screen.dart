import 'package:flutter/material.dart';
import 'package:hello_flutter_wirh_intellij/screens/navigator_practice/second_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('First'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) => const SecondScreen())
                    );
                  },
                  child: const Text('Go to Second Screen'))
            ],
          ),
        )
    );
  }
}
