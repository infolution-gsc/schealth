import 'package:flutter/material.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chips_choice/chips_choice.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  bool pressAttention1 = true;
  bool pressAttention2 = false;
  bool pressAttention3 = false;
  bool pressAttention4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueBackground,
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(top: 20, left: 20),
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Add Health Habit',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: blueBackground,
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 28,
              width: 312,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: blueChoiceBackground),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor:
                          pressAttention1 ? button1 : blueChoiceBackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.only(right: 12, left: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        pressAttention1 = true;
                        pressAttention2 = false;
                        pressAttention3 = false;
                        pressAttention4 = false;
                      });
                    },
                    child: Text(
                      ('Suggested'),
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: pressAttention1 ? blueBackground : button1),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor:
                          pressAttention2 ? button1 : blueChoiceBackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.only(right: 12, left: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        pressAttention1 = false;
                        pressAttention2 = true;
                        pressAttention3 = false;
                        pressAttention4 = false;
                      });
                    },
                    child: Text(
                      ('Health'),
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: pressAttention2 ? blueBackground : button1),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor:
                          pressAttention3 ? button1 : blueChoiceBackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.only(right: 12, left: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        pressAttention1 = false;
                        pressAttention2 = false;
                        pressAttention3 = true;
                        pressAttention4 = false;
                      });
                    },
                    child: Text(
                      ('Sports'),
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: pressAttention3 ? blueBackground : button1),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor:
                          pressAttention4 ? button1 : blueChoiceBackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.only(right: 12, left: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        pressAttention1 = false;
                        pressAttention2 = false;
                        pressAttention3 = false;
                        pressAttention4 = true;
                      });
                    },
                    child: Text(
                      ('Body Care'),
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: pressAttention4 ? blueBackground : button1),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
