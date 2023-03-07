import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.text,
    required this.color,
    required this.colorText,
  }) : super(key: key);
  final String text;
  final Color color;
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: CircleAvatar(
        backgroundColor: color,
        radius: 30,
        child: Text(text,
            style: TextStyle(
              color: colorText,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
