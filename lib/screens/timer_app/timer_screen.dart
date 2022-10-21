import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sprintf/sprintf.dart';

enum TimerStatus {
  running,
  paused,
  stopped,
  resting
}


class TimerScreen extends StatefulWidget{
  @override
  _TimerScreenState createState() => _TimerScreenState();

}

class _TimerScreenState extends State<TimerScreen> {
  static const WORK_SECONDS = 10;
  static const REST_SECONDS = 5;

  late  TimerStatus _timerStatus;
  late int _timer;
  late int _pomodoroCount;

  @override
  void initState () {
    super.initState();
    _timerStatus = TimerStatus.stopped;
    _timer = WORK_SECONDS;
    _pomodoroCount = 0;
  }

  String secondsToString (int seconds) {
    return sprintf("%02d:%02d", [seconds ~/ 60, seconds % 60]);
  }

  void run () {
    setState (() {
      _timerStatus = TimerStatus.running;
    });
    runTimer();
  }

  void pause () {
    setState (() {
      _timerStatus = TimerStatus.paused;
    });
  }

  void resume () {
    run();
  }

  void stop () {
    setState (() {
      _timer = WORK_SECONDS;
      _timerStatus = TimerStatus.stopped;
    });
  }

  void rest () {
    setState (() {
      _timer = REST_SECONDS;
      _timerStatus = TimerStatus.resting;
    });
  }

  void runTimer () {
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      switch (_timerStatus) {
        case TimerStatus.running:
          if(_timer > 0){
            setState (() => _timer--);
          } else {
            // t.cancel();
            showToast('resting 시작!');
            rest();
          }
          break;

        case TimerStatus.resting:
          if(_timer > 0) {
            setState (() => _timer--);
          } else {
            setState (() => _pomodoroCount++);
            // debugPrint("뽀모도로 $_pomodoroCount개 달성~,~");
            showToast("뽀모도로 $_pomodoroCount개 달성~,~");
            t.cancel();
            stop();
          }
          break;

        case TimerStatus.stopped:
        case TimerStatus.paused:
          t.cancel();
          break;

        default:
          break;
      }
    });
  }

  void showToast (String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      // timeInSecForIosWeb: 5,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _runningButtons = [
      ElevatedButton(
        onPressed: _timerStatus == TimerStatus.paused ? resume : pause,
        style: ElevatedButton.styleFrom(primary: Colors.blue),
        child: Text(
          _timerStatus == TimerStatus.paused ? '계속하기' : '정지하기',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      const Padding(padding: EdgeInsets.all(20),),
      ElevatedButton(
        onPressed: stop,
        style: ElevatedButton.styleFrom(primary: Colors.grey),
        child: const Text(
          '포기하기',
          style: TextStyle(fontSize: 16),
        )
      ),

    ];
    final List<Widget> _stoppedButtons = [
      ElevatedButton(
        onPressed: run,
        style: ElevatedButton.styleFrom(
            primary:
              _timerStatus == TimerStatus.resting ? Colors.green : Colors.blue) ,
        child: const Text(
          '시작하기',
          style: TextStyle(color: Colors.white, fontSize: 16),
        )
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('뽀모도로 타이머')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _timerStatus == TimerStatus.resting ? Colors.green : Colors.blue
            ),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Center(
              child: Text(
                secondsToString(_timer),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _timerStatus == TimerStatus.resting
                ? const []
                : _timerStatus == TimerStatus.stopped
                    ? _stoppedButtons
                    : _runningButtons
            ,
          )
        ],
      ),
    );
  }

}
