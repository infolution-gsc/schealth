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
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
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
                            backgroundColor: pressAttention1
                                ? button1
                                : blueChoiceBackground,
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
                                color:
                                    pressAttention1 ? blueBackground : button1),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: pressAttention2
                                ? button1
                                : blueChoiceBackground,
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
                                color:
                                    pressAttention2 ? blueBackground : button1),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: pressAttention3
                                ? button1
                                : blueChoiceBackground,
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
                                color:
                                    pressAttention3 ? blueBackground : button1),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: pressAttention4
                                ? button1
                                : blueChoiceBackground,
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
                                color:
                                    pressAttention4 ? blueBackground : button1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  pressAttention1
                      ? Container(
                          width: 312,
                          height: 48,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: button1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Drink Water',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: blueColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: blueColor),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  pressAttention2
                      ? Container(
                          width: 312,
                          height: 48,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: button1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Consume Fruits and Vegetables',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: blueColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: blueColor),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  pressAttention2
                      ? SizedBox(
                          height: 10,
                        )
                      : Container(),
                  pressAttention2
                      ? Container(
                          width: 312,
                          height: 48,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: button1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sleep Well',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: blueColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: blueColor),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  pressAttention3
                      ? Container(
                          width: 312,
                          height: 48,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: button1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Gym',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: blueColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: blueColor),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  pressAttention3
                      ? SizedBox(
                          height: 10,
                        )
                      : Container(),
                  pressAttention3
                      ? Container(
                          width: 312,
                          height: 48,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: button1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Swimming',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: blueColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: blueColor),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  pressAttention4
                      ? Container(
                          width: 312,
                          height: 48,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: button1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Medical Check Up',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: blueColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: blueColor),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  pressAttention4
                      ? SizedBox(
                          height: 10,
                        )
                      : Container(),
                  pressAttention4
                      ? Container(
                          width: 312,
                          height: 48,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: button1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Personal Hygiene',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: blueColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: blueColor),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              )
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
              Container(
                width: 300,
                height: 54,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(button1),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Add Habit',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: blueColor),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
