import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:day11/my_widgets/timer_button.dart';

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
  var selectedMinIndex = 3; //선택된 시간 인덱스
  var totalSec = 1500; //시간 카운터
  var totalPomodoroSec = 1500; //설정한  Pomodoro 카운트시간(default = 1500초)
  var passedSec = 0; //지나간 시간(초)
  var totalRestSec = 300; //설정한 Rest모드 카운트시간(default = 300)
  var goalCount = 0; //달성한 POMODORO 횟수
  late String formattedTime; //MM:SS형식으로 format한 타이머
  bool isRunning = false; //타이머가 작동중인지
  bool isRestTime = false; //Rest time, Pomodoro time 2가지 존재
  late Timer timer;

  String formatDuration(Duration d) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void onClickStart() {
    setState(() {
      isRunning = true;
    });
    timer = Timer.periodic(
      const Duration(milliseconds: 3),
      (timer) {
        setState(() {
          if (passedSec < totalSec) {
            //타이머가 남아있을경우
            passedSec++;
            formattedTime =
                formatDuration(Duration(seconds: totalSec - passedSec));
          } else {
            //타이머가 0이 될 경우
            if (!isRestTime) {
              //Pomodoro모드였을경우
              goalCount++;
            } else {
              //Rest모드였을경우
              timer.cancel();
              isRunning = false;
            }
            passedSec = 0;
            changeMode();
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

  //Pomodoro와 Rest모드 변경
  void changeMode() {
    //카운터 세팅 변경
    if (isRestTime) {
      totalSec = totalPomodoroSec;
    } else {
      totalSec = totalRestSec;
    }
    formattedTime = formatDuration(Duration(seconds: totalSec - passedSec));
    //카운터 모드 변경
    isRestTime = !isRestTime;
  }

  @override
  void initState() {
    formattedTime = formatDuration(Duration(seconds: totalSec));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isRestTime ? Colors.green : Colors.red,
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Text(
                isRestTime ? "Rest Mode" : "Pomodoro Mode",
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 180,
              ),
              Text(
                formattedTime,
                style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SizedBox(
                width: 350,
                child: LinearProgressIndicator(
                  value: passedSec / totalSec, // 0.0 ~ 1.0 사이의 값
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 163, 163, 163)),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                height: 50,
                child: isRunning || isRestTime || goalCount != 0
                    ? null
                    : Stack(
                        children: <Widget>[
                          ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: totalMin.length,
                            itemBuilder: (context, index) {
                              return TimerButton(
                                value: totalMin[index],
                                onClick: () {
                                  setState(() {
                                    passedSec = 0;
                                    totalPomodoroSec = totalMin[index] * 60;
                                    totalSec = totalPomodoroSec;
                                    formattedTime = formatDuration(Duration(
                                        seconds: totalSec - passedSec));
                                  });
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 15,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            child: IgnorePointer(
                              child: Container(
                                width: 130.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.35),
                                      Colors.black.withOpacity(0.0)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            child: IgnorePointer(
                              child: Container(
                                width: 130.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.0),
                                      Colors.black.withOpacity(0.35)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(
                height: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    hoverColor: const Color(0x00000000),
                    focusColor: const Color(0x00000000),
                    highlightColor: const Color(0x00000000),
                    splashColor: const Color(0x00000000),
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
                  SizedBox(
                    child: isRunning || isRestTime
                        ? null
                        : GestureDetector(
                            onLongPress: () {
                              setState(() {
                                goalCount = 0;
                                passedSec = 0;
                                formattedTime = formatDuration(
                                    Duration(seconds: totalSec - passedSec));
                              });
                            },
                            child: IconButton(
                              hoverColor: const Color(0x00000000),
                              focusColor: const Color(0x00000000),
                              highlightColor: const Color(0x00000000),
                              splashColor: const Color(0x00000000),
                              padding: const EdgeInsets.all(0.0),
                              constraints: const BoxConstraints.tightFor(
                                width: 40,
                                height: 40,
                              ),
                              onPressed: () {
                                setState(() {
                                  passedSec = 0;
                                  formattedTime = formatDuration(
                                      Duration(seconds: totalSec - passedSec));
                                });
                              },
                              icon: const Icon(Icons.restart_alt,
                                  size: 20, color: Colors.white),
                            ),
                          ),
                  ),
                ],
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

//Todo
//리셋버튼 클릭범위 줄이기
//라운드 끝나면 bigRestTime모드 만들어서 배경색 검정, 쉬는시간 크게... + isRestMode -> enum으로 mode변수 다시 구성
//카운터 위젯으로 꾸미기