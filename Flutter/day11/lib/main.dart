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
  var totalSec = 1500; //시간 카운터
  var totalPomodoroSec = 1500; //설정한  Pomodoro 카운트시간(default = 1500초)
  var passedSec = 0; //지나간 시간(초)
  var totalRestSec = 10; //설정한 Rest모드 카운트시간(default = 300)
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
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          if (passedSec < totalSec) {
            passedSec++;
            formattedTime =
                formatDuration(Duration(seconds: totalSec - passedSec));
            isRunning = true;
          } else {
            if (!isRestTime) {
              goalCount++;
            }
            passedSec = 0;
            timer.cancel();
            isRunning = false;
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
                          formattedTime = formatDuration(
                              Duration(seconds: totalSec - passedSec));
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
              TextButton(
                onPressed: () {
                  setState(() {
                    totalSec = 10;
                    passedSec = 0;
                    formattedTime =
                        formatDuration(Duration(seconds: totalSec - passedSec));
                  });
                },
                child: const Text("Test"),
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

//Todo
// Play버튼 누르면 즉시 아이콘 변경
// 시간설정 관련 - Rest Mode 시간설정(중도변경은 x 초기 설정o), Pomodoro Mode 플레이하면 시간설정창 x
//타이머 리셋 + 완전리셋
//타이머에 맞는 진행률 바
//ListView 가장자리 투명도 주기
//라운드 끝나면 bigRestTime모드 만들어서 배경색 검정, 쉬는시간 크게... + isRestMode -> enum으로 mode변수 다시 구성
//RestMode는 시작되자마자 타이머 자동재생
//카운터 위젯으로 꾸미기