// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:healthy_planner/controller/task.dart';

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

  void deadlineMaker() {
    DateTime now = DateTime.now();
    DateTime diff = DateTime(widget.deadlineDate.year,
        widget.deadlineDate.month, widget.deadlineDate.day);
    if (now.difference(diff).inDays == 0) {
      setState(() {
        deadline = 'Today';
      });
    } else if (now.difference(diff).inDays == -1) {
      setState(() {
        deadline = 'Tomorrow';
      });
    } else if (now.difference(diff).inDays == 1) {
      setState(() {
        deadline = 'Yesterday';
      });
    } else if (now.difference(diff).inDays < 1) {
      int sel = now.difference(diff).inDays;
      int dl = sel.abs();
      setState(() {
        deadline = '$dl days left';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // formatTime();
    deadlineMaker();
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
                                              widget.deadlineTime,
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
                                                bottomLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            color: Color(0xFF306BCE),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Text(
                                                      "Focus Now!",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFD8E6FD),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Color(0xFFD8E6FD),
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
                                          color: const Color(0xFFFECDCA)),
                                      child: Text(
                                        widget.filterDropdown == 'Deadline'
                                            ? deadline
                                            : widget.priority,
                                        style: const TextStyle(
                                            color: Color(0xFFB42318),
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
                                  color:
                                      const Color.fromRGBO(250, 250, 250, 0.6),
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          : Container()
                    ],
                  ),
                ),
              ]),
        ));
  }
}
