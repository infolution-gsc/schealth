// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'round_button.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

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
      FlutterRingtonePlayer.playNotification();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
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
              SizedBox(
                width: 250,
                height: 250,
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  radius: 125.0,
                  backgroundColor: Colors.transparent,
                  percent: progress,
                  lineWidth: 22,
                  progressColor: Color(0xFF306BCE),
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
                            SizedBox(
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
                                color: Color(0xFF306BCE),
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
                GestureDetector(
                  onTap: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value);
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: RoundButton(
                    color: Color(0xFF306BCE),
                    text: isPlaying == true ? "Pause" : "Play",
                    colorText: Color(0xFFFFFFFF),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                  child: RoundButton(
                    color: Color(0xFF9CC0FB),
                    text: "Reset",
                    colorText: Color(0xFF306BCE),
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
