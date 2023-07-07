import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  final int value;
  final Function() onClick;

  const TimerButton({required this.value, required this.onClick, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 20,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(0.6),
            width: 3,
          ),
        ),
        child: Center(
          child: Text(
            "$value",
            style: const TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
