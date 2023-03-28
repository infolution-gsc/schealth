// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthy_planner/controller/noti.dart';
import 'round_button.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:percent_indicator/percent_indicator.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late bool longBreak;
  Color colorIndicator = Color(0xFF306BCE);

  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  void notify() {
    if (countText == '0:00:00') {
      Notif.showNotificatios(
        title: 'Time is up',
        body: 'Time is up',
        fln: flutterLocalNotificationsPlugin,
      );
      if (longBreak == true) {
        longBreak = false;
      } else {
        longBreak = true;
      }
      if (longBreak == true) {
        controller.duration = Duration(minutes: 25);
      } else {
        controller.duration = Duration(minutes: 5);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    longBreak = false;

    controller.addListener(() {
      if (controller.isAnimating) {
        notify();
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Color(0xFFFAFAFA),
                  image: DecorationImage(
                    image: const AssetImage('assets/bg/bgC.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFF9CC0FB),
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ],
                  // backgroundBlendMode: BlendMode.srcATop,
                ),
                width: 250,
                height: 250,
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  radius: 125.0,
                  backgroundColor: Colors.transparent,
                  percent: progress,
                  lineWidth: 22,
                  progressColor:
                      longBreak == true ? Color(0xFF132B52) : Color(0xFF306BCE),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (controller.isDismissed) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        height: 300,
                        child: CupertinoTimerPicker(
                          initialTimerDuration: controller.duration!,
                          onTimerDurationChanged: (time) {
                            setState(() {
                              controller.duration = time;
                            });
                          },
                        ),
                      ),
                    );
                  }
                },
                child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Column(
                          children: [
                            longBreak == true
                                ? Text(
                                    "Long Break",
                                    style: TextStyle(
                                      color: Color(0xFF132B52),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : SizedBox(
                                    height: 20,
                                  ),
                            Text(
                              countText,
                              style: TextStyle(
                                shadows: const <Shadow>[
                                  Shadow(
                                    offset: Offset(0, 0),
                                    blurRadius: 12.0,
                                    color: Color(0xFF9CC0FB),
                                  ),
                                ],
                                color: longBreak == true
                                    ? Color(0xFF132B52)
                                    : Color(0xFF306BCE),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "left",
                              style: TextStyle(
                                color: Color(0xFF616161),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.isAnimating) {
                        controller.stop();
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
                        controller.reverse(
                            from:
                                controller.value == 0 ? 1.0 : controller.value);
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Color(0xFF9CC0FB),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      backgroundColor: Color(0xFF306BCE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      isPlaying == true ? "Pause" : "Play",
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Color(0xFF9CC0FB),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    backgroundColor: Color(0xFF9CC0FB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Reset",
                    style: TextStyle(
                        color: Color(0xff306BCE), fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
