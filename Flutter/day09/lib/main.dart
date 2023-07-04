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
          PointerDeviceKind.unknown
        },
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFF222222),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: Image.asset(
                      "lib/assets/flutter.png",
                      scale: 7,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    constraints: const BoxConstraints.tightFor(
                      width: 65,
                      height: 65,
                    ),
                    onPressed: () {},
                    padding: const EdgeInsets.all(0.0),
                    icon: const Icon(
                      Icons.add,
                      size: 55,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Monday 16",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    Text(
                      " Today ",
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " 15 ",
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " 16 ",
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " 17 ",
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " 18 ",
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " 19 ",
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " 20 ",
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " 21 ",
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " 22 ",
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 10,
                child: ListView(
                  children: [
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: const Center(
                        child: Text(
                          "DESIGN MEETING",
                          style: TextStyle(
                              fontSize: 65, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: const Center(
                        child: Text(
                          "DESIGN MEETING",
                          style: TextStyle(
                              fontSize: 65, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: const Center(
                        child: Text(
                          "DESIGN MEETING",
                          style: TextStyle(
                              fontSize: 65, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: const Center(
                        child: Text(
                          "DESIGN MEETING",
                          style: TextStyle(
                              fontSize: 65, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: const Center(
                        child: Text(
                          "DESIGN MEETING",
                          style: TextStyle(
                              fontSize: 65, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


//부족한 부분
//Layout 깔끔하게 잡는법
//ListView saperated같은거도 사용법 익숙해지기
//theme 사용법 익히기