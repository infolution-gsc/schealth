import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_planner/controller/taskController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:healthy_planner/widget/dropdown/drop_down_list.dart';
import 'package:healthy_planner/widget/dropdown/list_item.dart';

import '../widget/listTask.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final TaskController controller = TaskController();
  String? userId;
  String selectedCategory = 'All';
  String lengthTask = "";
  String valueDropdown = "Deadline";

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }

  List listDropdown = [
    "Deadline",
    "Priority",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 30,
                child: StreamBuilder<QuerySnapshot<Object?>>(
                    stream: controller.getDataLabel(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          var listAlldocs = snapshot.data!.docs;
                          List<String> listDataLabel = <String>["All"];
                          if (listAlldocs.isNotEmpty) {
                            for (var element = 0;
                                element < listAlldocs.length;
                                element++) {
                              var data = (listAlldocs[element].data()
                                  as Map<String, dynamic>)['label'];
                              listDataLabel.add(data);
                            }
                          }
                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: listDataLabel.length,
                            itemBuilder: (context, index) {
                              var doc = listDataLabel[index];
                              return ChoiceChip(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                backgroundColor: blueBackground,
                                selectedColor: const Color(0xFFD8E6FD),
                                label: Text(
                                  doc,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: selectedCategory == doc
                                        ? blueBackground
                                        : const Color(0xFFD8E6FD),
                                  ),
                                ),
                                selected: selectedCategory == doc,
                                onSelected: (value) {
                                  setState(() {
                                    selectedCategory = doc;
                                  });
                                },
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                              "Tidak ada data",
                              style: TextStyle(fontSize: 8),
                            ),
                          );
                        }
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Container(
                height: 75,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        spreadRadius: 9,
                        blurRadius: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.13),
                      ),
                    ],
                    color: const Color(0xFFFAFAFA),
                    // border: Border.all(color: const Color(0xFFFAFAFA)),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Container(
                      height: 75,
                      width: 85,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: blueBackground,
                              width: 2,
                              style: BorderStyle.solid),
                          color: blueBackground,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            StreamBuilder(
                                stream: controller.getData(
                                    selectedCategory, valueDropdown),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    if (snapshot.hasData) {
                                      var listAlldocs = snapshot.data!.docs;
                                      return Text(
                                        listAlldocs.length.toString() +
                                            " " +
                                            "Task",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text(
                                          "No data",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      );
                                    }
                                  } else {
                                    return const Center(
                                      child: Text(
                                        "Loading...",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Complete",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF262626),
                                ),
                              ),
                              StreamBuilder<QuerySnapshot<Object?>>(
                                  stream: controller.getData(
                                      selectedCategory, valueDropdown),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      if (snapshot.hasData) {
                                        var listAlldocs = snapshot.data!.docs;
                                        var listValue = [];
                                        double value = 0;
                                        if (listAlldocs.isNotEmpty) {
                                          listAlldocs.forEach((element) {
                                            if (element['complete'] == true) {
                                              listValue
                                                  .add(element['complete']);
                                            }
                                            var value1 = listValue.length;
                                            var value2 = listAlldocs.length;
                                            value = (value1 / value2) * 100;
                                          });
                                        } else {
                                          value = 0;
                                        }
                                        return SliderTheme(
                                          data: SliderThemeData(
                                            trackHeight: 6.0,
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                              enabledThumbRadius: 8.0,
                                            ),
                                            overlayColor: blueBackground,
                                            overlayShape:
                                                const RoundSliderOverlayShape(
                                              overlayRadius: 12.0,
                                            ),
                                            activeTrackColor: blueBackground,
                                            inactiveTrackColor:
                                                const Color(0xFfD9D9D9),
                                          ),
                                          child: Slider(
                                            value: value.toDouble(),
                                            min: 0.0,
                                            max: 100.0,
                                            onChanged: (newValue) {},
                                            divisions: 100,
                                            label: '10',
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          child: Text("Tidak ada Data"),
                                        );
                                      }
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  })
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Row(
                children: [
                  const Text(
                    "Sort By",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF262626),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                      value: valueDropdown,
                      items: const [
                        DropdownMenuItem(
                          child: Text("Deadline"),
                          value: "Deadline",
                        ),
                        DropdownMenuItem(
                          child: Text("Priority"),
                          value: "Priority",
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          valueDropdown = value.toString();
                        });
                      })
                  // DropDownList<String>(
                  //   listItems: const [
                  //     ListItem<String>(
                  //       'Deadline',
                  //       value: 'Deadline',
                  //     ),
                  //     ListItem<String>(
                  //       'Priority',
                  //       value: 'Priority',
                  //     ),
                  //   ],
                  //   value: valueDropdown,
                  //   onChange: (value) => setState(() {
                  //     print(value);
                  //   }),
                  // )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Object?>>(
                  stream: controller.getData(selectedCategory, valueDropdown),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        var listAlldocs = snapshot.data!.docs;
                        if (listAlldocs.isEmpty) {
                          return const Center(
                            child: Text('No Data'),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: listAlldocs.length,
                            itemBuilder: (context, index) {
                              var doc = listAlldocs[index];
                              DateTime dt = (doc.data()
                                      as Map<String, dynamic>)['deadlineDate']
                                  .toDate();
                              return ListTask(
                                filterDropdown: valueDropdown,
                                taskName: (doc.data()
                                    as Map<String, dynamic>)['name'],
                                deadlineDate: dt,
                                deadlineTime: (doc.data()
                                    as Map<String, dynamic>)['deadlineTime'],
                                note: (doc.data()
                                    as Map<String, dynamic>)['note'],
                                priority: (doc.data()
                                    as Map<String, dynamic>)['priority'],
                                reminder: (doc.data()
                                    as Map<String, dynamic>)['reminder'],
                                complete: (doc.data()
                                    as Map<String, dynamic>)['complete'],
                                userID: (doc.data()
                                    as Map<String, dynamic>)['user_id'],
                                category: (doc.data()
                                    as Map<String, dynamic>)['category'],
                                docId: doc.id,
                              );
                            },
                          );
                        }
                      }
                      return const Center(
                        child: Text("Tidak ada Data"),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            )
          ],
        )
        // body: FutureBuilder<QuerySnapshot<Object?>>(
        //     future: controller.getData(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         var listAlldocs = snapshot.data!.docs;
        //         return ListView.builder(
        //           itemCount: listAlldocs.length,
        //           itemBuilder: (context, index) {
        //             var doc = listAlldocs[index];
        //             DateTime dt =
        //                 (doc.data() as Map<String, dynamic>)['deadlineDate']
        //                     .toDate();
        //             return ListTask(
        //               taskName: (doc.data() as Map<String, dynamic>)['name'],
        //               deadlineDate: dt,
        //               deadlineTime:
        //                   (doc.data() as Map<String, dynamic>)['deadlineTime'],
        //               note: (doc.data() as Map<String, dynamic>)['note'],
        //               priority:
        //                   (doc.data() as Map<String, dynamic>)['priority'],
        //               reminder:
        //                   (doc.data() as Map<String, dynamic>)['reminder'],
        //               complete:
        //                   (doc.data() as Map<String, dynamic>)['complete'],
        //               userID: (doc.data() as Map<String, dynamic>)['user_id'],
        //             );
        //           },
        //         );
        //       }
        //       return const Center(child: CircularProgressIndicator());
        //     })
        );
  }
}
