import 'package:flutter/material.dart';
import 'package:hello_flutter_wirh_intellij/screens/navigator_practice//first_screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Second'),
              OutlinedButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (BuildContext context) => const FirstScreen())
                    // );
                    Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => const FirstScreen())
                    );
                  },
                  child: const Text('Go to First Screen'))
            ],
          ),
        )
    );
  }
}
