// ignore_for_file: sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthy_planner/controller/noti.dart';
import 'package:healthy_planner/controller/taskController.dart';
import 'package:healthy_planner/widget/edit/editTask.dart';
import 'package:healthy_planner/widget/transitions/slide_transitions.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class ListTask extends StatefulWidget {
  final String filterDropdown;
  final String taskName;
  final DateTime deadlineDate;
  final String deadlineTime;
  final String note;
  final String priority;
  final String reminder;
  final bool complete;
  final String userID;
  final String docId;
  final String category;

  const ListTask(
      {super.key,
      required this.filterDropdown,
      required this.userID,
      required this.taskName,
      required this.deadlineDate,
      required this.deadlineTime,
      required this.note,
      required this.priority,
      required this.category,
      required this.reminder,
      required this.complete,
      required this.docId});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  TaskController controller = TaskController();

  late String time;
  late String deadline = "";
  late Color colordl = Color(0xFFB42318);
  late Color colorpri = Color(0xFFB42318);
  late Color containerPri = Color(0xFfFECDCA);
  late Color containerdl = Color(0xFFFECDCA);

  // void formatTime() {
  //   String hour;
  //   String min;
  //   if (widget.deadlineTime[2] == ':') {
  //     hour = widget.deadlineTime.substring(0, 2);
  //     min = widget.deadlineTime.substring(3, 5);
  //     if (widget.deadlineTime[6] == 'P') {
  //       hour = (int.parse(hour) + 12).toString();
  //     }
  //   } else {
  //     hour = '0${widget.deadlineTime.substring(0, 1)}';
  //     min = widget.deadlineTime.substring(2, 4);
  //     if (widget.deadlineTime[5] == 'P') {
  //       hour = (int.parse(hour) + 12).toString();
  //     }
  //   }
  //   setState(() {
  //     time = '$hour:$min';
  //   });
  // }

  void deadlineMaker(int hour, int minute) {
    DateTime now = DateTime.now();
    DateTime diff = DateTime(
      widget.deadlineDate.year,
      widget.deadlineDate.month,
      widget.deadlineDate.day,
      hour,
      minute,
    );
    if (diff.difference(now).inHours < 24 && diff.difference(now).inHours > 0) {
      int dl = diff.difference(now).inHours;
      setState(() {
        deadline = '$dl hours left';
        colordl = Color(0xFFB42318);
      });
    } else if (diff.difference(now).inHours > 24 &&
        diff.difference(now).inHours < 48) {
      setState(() {
        deadline = 'Tomorrow';
        colordl = Color(0xFF027A48);
      });
    } else if (diff.difference(now).inHours > 48) {
      int dl = (diff.difference(now).inHours / 24).round();
      setState(() {
        deadline = '$dl days left';
        colordl = Color(0xFF027A48);
        containerdl = Color(0xFFA6F4C5);
      });
    } else if (diff.difference(now).inHours < 0) {
      setState(() {
        deadline = 'Missed';
        colordl = Color(0xFFB42318);
      });
    } else if (diff.difference(now).inHours == 0) {
      int dl = diff.difference(now).inMinutes;
      if (dl > 0) {
        setState(() {
          deadline = '$dl minutes left';
          colordl = Color(0xFF027A48);
        });
      } else {
        setState(() {
          deadline = 'Missed';
          colordl = Color(0xFFB42318);
        });
      }
    }
  }

  late String sendTitle;
  late String sendDate;
  late String sendTime;
  late String sendNote;
  late String sendPriority;
  late String sendReminder;
  late String sendCategory;
  late String timeFormat;
  late String prio;
  late DateTime remind;

  @override
  void initState() {
    super.initState();
    if (widget.taskName.isEmpty) {
      setState(() {
        sendTitle = 'No Title';
      });
    } else {
      setState(() {
        sendTitle = widget.taskName;
      });
    }

    if (widget.deadlineDate == DateTime.now()) {
      setState(() {
        sendDate = 'No Date';
      });
    } else {
      setState(() {
        sendDate = widget.deadlineDate.toString();
      });
    }

    if (widget.deadlineTime.isEmpty) {
      setState(() {
        sendTime = 'No Time';
      });
    } else {
      setState(() {
        sendTime = widget.deadlineTime;
      });
    }

    if (widget.note.isEmpty) {
      setState(() {
        sendNote = 'No Note';
      });
    } else {
      setState(() {
        sendNote = widget.note;
      });
    }

    if (widget.priority.isEmpty) {
      setState(() {
        sendPriority = 'No Priority';
      });
    } else {
      setState(() {
        sendPriority = widget.priority;
      });
    }

    if (widget.reminder.isEmpty) {
      setState(() {
        sendReminder = 'No Reminder';
      });
    } else {
      setState(() {
        sendReminder = widget.reminder;
      });
    }

    if (widget.category.isEmpty) {
      setState(() {
        sendCategory = 'No Category';
      });
    } else {
      setState(() {
        sendCategory = widget.category;
      });
    }

    var temp = widget.deadlineTime.split(':');
    String hour;
    String minute;
    if (temp[0].length == 1) {
      hour = '0${temp[0]}';
    } else {
      hour = temp[0];
    }
    if (temp[1].length == 1) {
      minute = '0${temp[1]}';
    } else {
      minute = temp[1];
    }

    timeFormat = "${hour}:${minute}";

    // formatTime();
    customPriority(widget.priority);
    deadlineMaker(int.parse(temp[0]), int.parse(temp[1]));

    remind = DateTime(
      widget.deadlineDate.year,
      widget.deadlineDate.month,
      widget.deadlineDate.day,
      int.parse(hour),
      int.parse(minute),
    );

    Timer.periodic(Duration(minutes: 1), (Timer t) {
      if (remind.year == DateTime.now().year) {
        if (remind.month == DateTime.now().month) {
          if (remind.day == DateTime.now().day) {
            Notif.showNotificatios(
                title: "Task Reminder",
                body: "$sendTitle 's deadline is today!",
                fln: flutterLocalNotificationsPlugin);
            t.cancel();
          }
        }
      }
    });
  }

  void customPriority(String value) {
    if (value == "1") {
      setState(() {
        prio = "High Priority";
        colorpri = const Color(0xFFB42318);
        containerPri = const Color(0xFFFECDCA);
        sendPriority = prio;
      });
    } else if (value == "2") {
      setState(() {
        prio = "Medium Priority";
        colorpri = const Color(0xFF93370D);
        containerPri = const Color(0xFFFEF0C7);
        sendPriority = prio;
      });
    } else if (value == "3") {
      setState(() {
        prio = "Low Priority";
        colorpri = const Color(0xFF027A48);
        containerPri = const Color(0xFFA6F4C5);
        sendPriority = prio;
      });
    } else if (value == "4") {
      setState(() {
        prio = "No Priority";
        colorpri = const Color(0xFF027A48);
        containerPri = const Color(0xFFA6F4C5);
        sendPriority = prio;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Checkbox(
                    value: widget.complete,
                    side: const BorderSide(width: 2, color: Color(0xFF306BCE)),
                    onChanged: (value) {
                      controller.updateComplete(widget.complete, widget.docId);
                    },
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          SlideTopRoute(
                              page: EditTask(
                            getDate: widget.deadlineDate,
                            getFormTime: sendTime,
                            getPriority: sendPriority,
                            getReminder: sendReminder,
                            getLabel: sendCategory,
                            getNote: sendNote,
                            getTitle: sendTitle,
                            docId: widget.docId,
                          )));
                    },
                    child: Stack(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 0),
                                    spreadRadius: 9,
                                    blurRadius: 13,
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                  ),
                                ],
                                color: const Color(0xFFFAFAFA),
                                border:
                                    Border.all(color: const Color(0xFFFAFAFA)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.taskName,
                                            style: const TextStyle(
                                                color: Color(0xFF262626),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.access_time,
                                                size: 12,
                                                color: Color(0xFF306BCE),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                timeFormat,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF9E9E9E)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    !widget.complete
                                        ? Container(
                                            width: 76,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10)),
                                              color: Color(0xFF306BCE),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Text(
                                                        "Focus Now!",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFD8E6FD),
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color:
                                                            Color(0xFFD8E6FD),
                                                        size: 8,
                                                      )
                                                    ])
                                              ],
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: widget.filterDropdown ==
                                                    "Deadline"
                                                ? containerdl
                                                : containerPri),
                                        child: Text(
                                          widget.filterDropdown == 'Deadline'
                                              ? deadline
                                              : prio,
                                          style: widget.filterDropdown ==
                                                  "Deadline"
                                              ? TextStyle(
                                                  color: colordl,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500)
                                              : TextStyle(
                                                  color: colorpri,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Text(
                                          "Details",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Color(0xFF306BCE),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        widget.complete
                            ? Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        250, 250, 250, 0.6),
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ]),
        ));
  }
}
