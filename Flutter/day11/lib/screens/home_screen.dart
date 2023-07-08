import 'dart:async';

import 'package:flutter/material.dart';
import './setting_screen.dart';
import '../my_widgets/timer_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  var totalRestSec = 300; //설정한 Rest모드 카운트시간(default = 300)
  var passedSec = 0; //지나간 시간(초)
  var goalCount = 0; //달성한 POMODORO 횟수
  late String formattedTime; //MM:SS형식으로 format한 타이머 시간
  bool isTimerRunning = false; //타이머가 작동중인지
  bool isRestTime = false; //Rest time, Pomodoro time 2가지 존재
  late Timer timer;

  //Sec형식의 타이머를 MM:DD형식으로 formatting
  String toFormattedTime(Duration d) {
    String toTwoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = toTwoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = toTwoDigits(d.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
  //Timer의 Play버튼을 누르면
  void onClickStart() {
    setState(() {
      isTimerRunning = true;
    });
    timer = Timer.periodic(
      const Duration(milliseconds: 3),
      (timer) {
        setState(() {
          if (passedSec < totalSec) {
            //타이머가 남아있을경우
            passedSec++;
            formattedTime =
                toFormattedTime(Duration(seconds: totalSec - passedSec));
          } else {
            //타이머가 0이 될 경우
            if (!isRestTime) {
              //Pomodoro모드였을경우
              goalCount++;
            } else {
              //Rest모드였을경우
              timer.cancel();
              isTimerRunning = false;
            }
            passedSec = 0;
            changeMode();
          }
        });
      },
    );
  }
  //Timer의 Pause버튼을 누르면
  void onClickPause() {
    setState(() {
      timer.cancel();
      isTimerRunning = false;
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
    formattedTime = toFormattedTime(Duration(seconds: totalSec - passedSec));
    //카운터 모드 변경
    isRestTime = !isRestTime;
  }

  @override
  void initState() {
    formattedTime = toFormattedTime(Duration(seconds: totalSec));
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
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Text(
                  isRestTime ? "Rest Mode" : "Pomodoro Mode",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
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
              child: isTimerRunning || isRestTime || goalCount != 0
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
                                  formattedTime = toFormattedTime(
                                      Duration(seconds: totalSec - passedSec));
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          child: IgnorePointer(
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.red.withOpacity(0.7),
                                    Colors.red.withOpacity(0.0)
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
                              width: 100.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.red.withOpacity(0.0),
                                    Colors.red.withOpacity(0.7)
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
                  onPressed: isTimerRunning ? onClickPause : onClickStart,
                  icon: isTimerRunning
                      ? const Icon(Icons.pause, size: 70, color: Colors.white)
                      : const Icon(Icons.play_arrow,
                          size: 70, color: Colors.white),
                ),
                SizedBox(
                  child: isTimerRunning || isRestTime
                      ? null
                      : GestureDetector(
                          onLongPress: () {
                            setState(() {
                              goalCount = 0;
                              passedSec = 0;
                              formattedTime = toFormattedTime(
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
                                formattedTime = toFormattedTime(
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
              height: 80,
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
      ),
    );
  }
}

//Todo
//세부설정창 생성 - restTime, ROundFinishTime,등 수정가능
//목표 카운트 완료시 축하화면
//카운터 위젯으로 꾸미기
//히스토리창 생성
//모드 전면개편 - Pomodoro, rest, RoundFinish모드 3개로
