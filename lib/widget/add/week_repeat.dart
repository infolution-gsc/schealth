import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/utils/theme.dart';

class WeekRepeat extends StatefulWidget {
  const WeekRepeat({super.key});

  @override
  State<WeekRepeat> createState() => WeekRepeatState();
}

class WeekRepeatState extends State<WeekRepeat> {
  bool pressAttention1 = true;
  bool pressAttention2 = true;
  bool pressAttention3 = true;
  bool pressAttention4 = true;
  bool pressAttention5 = true;
  bool pressAttention6 = true;
  bool pressAttention7 = true;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 60,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: pressAttention1 ? button1 : button2),
            onPressed: () {
              setState(() {
                pressAttention1 = false;
                pressAttention2 = true;
                pressAttention3 = true;
                pressAttention4 = true;
                pressAttention5 = true;
                pressAttention6 = true;
                pressAttention7 = true;
              });
            },
            child: Text(
              'Study',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: pressAttention1 ? blueColor : button1),
            )),
      ),
    ]);
  }
}
