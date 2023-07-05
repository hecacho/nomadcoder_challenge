import 'dart:ui';
import 'package:flutter/material.dart';

List<Color> colorSet = [
  const Color(0xFFFFB84C),
  const Color(0xFFF266AB),
  const Color(0xFFA459D1),
  const Color(0xFF2CD3E1),
  const Color(0xFF41644A),
  const Color(0xFF009FBD),
  const Color(0xFFAD7BE9),
  const Color(0XFFFF6E31),
  const Color(0xFF1C315F),
  const Color(0xFF4856D2),
];

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
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 1,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    if (index == 7) {
                      return const Text(
                        "Today",
                        style: TextStyle(
                            fontSize: 40,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w600),
                      );
                    } else {
                      return Text(
                        '${index + 1}',
                        style: const TextStyle(
                            fontSize: 40, color: Color(0xFF999999)),
                      );
                    }
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Todo",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15,),
              Expanded(
                flex: 10,
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return TodoListTile(
                      title: "Programming",
                      startTime: "13:20",
                      endTime: "14:20",
                      detail: "study Flutter hard!",
                      backgroundColor: colorSet[index],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TodoListTile extends StatefulWidget {
  final String title;
  final String startTime, endTime;
  final String detail;
  final Color backgroundColor;

  const TodoListTile({
    super.key,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.detail,
    required this.backgroundColor,
  });

  @override
  State<TodoListTile> createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.check_box_outline_blank),
                  ),
                ],
              ),
              Text(
                "${widget.startTime} ~ ${widget.endTime}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.detail,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ));
  }
}
