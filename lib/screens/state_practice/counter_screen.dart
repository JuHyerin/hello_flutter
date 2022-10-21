import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget{
  const CounterScreen({super.key});

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late int count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = 0;
  }

  void increase () => setState(() {
    count++;
  });

  void decrease () => setState(() {
    count--;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('count: $count', style: const TextStyle(fontSize: 25)),
            const Padding(padding: EdgeInsets.all(30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: decrease, child: const Text('-')),
                ElevatedButton(onPressed: increase, child: const Text('+')),
              ],
            )
          ],
        )
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // Widget 이 사라질 때 수행
  }
}
