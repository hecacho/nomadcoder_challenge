import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      home: const MyPomodoroScreen(),
    );
  }
}

class MyPomodoroScreen extends StatefulWidget {
  const MyPomodoroScreen({
    super.key,
  });

  @override
  State<MyPomodoroScreen> createState() => _MyPomodoroScreenState();
}

class _MyPomodoroScreenState extends State<MyPomodoroScreen> {
  final totalMin = [
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
    55,
    60
  ]; //totalSec설정시 사용될 리스트
  var totalSec = 1500; //설정한 카운트시간(default = 1500초)
  var passedSec = 0; //지나간 시간(초)
  bool isRunning = false; //타이머가 작동중인지
  var goalCount = 0; //달성한 POMODORO 횟수
  late Timer timer;

  void onClickStart() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          if (passedSec < totalSec) {
            //카운트
            passedSec++;
            isRunning = true;
          } else {
            //카운트가 끝나면
            goalCount++;
            passedSec = 0;
            timer.cancel();
            isRunning = false;
          }
        });
      },
    );
  }

  void onClickPause() {
    setState(() {
      timer.cancel();
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Text(
                "Pomodoro",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 180,
              ),
              Text(
                "${totalSec - passedSec}",
                style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          totalSec = totalMin[index] * 60;
                          passedSec = 0;
                        });
                      },
                      child: Container(
                        height: 20,
                        width: 60,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.white.withOpacity(0.6),
                          width: 3,
                        )),
                        child: Center(
                          child: Text(
                            "${totalMin[index]}",
                            style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              IconButton(
                constraints: const BoxConstraints.tightFor(
                  width: 100,
                  height: 100,
                ),
                onPressed: isRunning ? onClickPause : onClickStart,
                icon: isRunning
                    ? const Icon(Icons.pause, size: 70, color: Colors.white)
                    : const Icon(Icons.play_arrow,
                        size: 70, color: Colors.white),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "${goalCount ~/ 4}/4",
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color(0x77cccccc)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Round",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$goalCount/12",
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color(0x77cccccc)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Goal",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
