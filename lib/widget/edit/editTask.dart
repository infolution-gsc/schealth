// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/controller/taskController.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditTask extends StatefulWidget {
  final String getTitle;
  final DateTime getDate;
  final String getFormTime;
  final String getPriority;
  final String getReminder;
  final String getLabel;
  final String getNote;
  final String docId;
  const EditTask(
      {super.key,
      this.restorationId,
      required this.getDate,
      required this.getFormTime,
      required this.getPriority,
      required this.getReminder,
      required this.getLabel,
      required this.getNote,
      required this.docId,
      required this.getTitle});

  @override
  State<EditTask> createState() => _EditTaskState();

  final String? restorationId;
}

class _EditTaskState extends State<EditTask> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  late DateTime _inputDate;
  late String _inputTime;
  late String _inputFormTime;
  late String _inputForm;
  late String priority = "No Priority";
  late String reminder = "5 Minutes Before";
  late String labelSelected = "Others";
  final TaskController controller = TaskController();

  TextEditingController dateC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController noteC = TextEditingController();

  TextEditingController _labelController = TextEditingController();

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  late String uid;
  bool disableTitle = false;
  bool disableNote = false;
  late String initialDate;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
      });
    }

    nameC.text = widget.getTitle;
    noteC.text = widget.getNote;

    initialDate =
        '${widget.getDate.day}/${widget.getDate.month}/${widget.getDate.year} : ${widget.getFormTime}';
    dateC.text = initialDate;
    priority = widget.getPriority;
    reminder = widget.getReminder;
    labelSelected = widget.getLabel;
  }

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) async {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        setState(() {
          _inputDate = _selectedDate.value;
          _inputForm =
              '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
          dateC.text = _inputForm;
        });
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(
        //       'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        // ));
      });
    }
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() {
        _inputTime = '${time.hour}:${time.minute}';
        if (time.minute < 10) {
          _inputFormTime = '${time.hour}:0${time.minute}';
        } else {
          _inputFormTime = '${time.hour}:${time.minute}';
        }
        dateC.text = '$_inputForm - $_inputFormTime';
      });
    }
  }

  void todayDate() {
    setState(() {
      _selectedDate.value = DateTime.now();
      _inputDate = _selectedDate.value;
      _inputForm =
          '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      dateC.text = _inputForm;
    });
  }

  void tomorrowDate() {
    setState(() {
      _selectedDate.value = DateTime.now().add(const Duration(days: 1));
      _inputDate = _selectedDate.value;
      _inputForm =
          '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      dateC.text = _inputForm;
    });
  }

  void nextWeekDate() {
    setState(() {
      _selectedDate.value = DateTime.now().add(const Duration(days: 7));
      _inputDate = _selectedDate.value;
      _inputForm =
          '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      dateC.text = _inputForm;
    });
  }

  List<String> listPriority = <String>[
    'No Priority',
    'Low Priority',
    'Medium Priority',
    'High Priority'
  ];

  List<String> listReminder = <String>[
    '5 Minutes Before',
    '15 Minutes Before',
    '30 Minutes Before',
    'Custom'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: blueBackground,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
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
            'Detail Task',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 30, right: 20),
              height: 235,
              decoration: BoxDecoration(
                  color: blueBackground,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 35,
                      child: TextFormField(
                          controller: nameC,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  disableTitle = true;
                                });
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Deadline',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 35,
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 2.5),
                      child: TextFormField(
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        controller: dateC,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              _restorableDatePickerRouteFuture.present();
                            },
                            icon: const Icon(Icons.calendar_month),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 78,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: button1,
                                ),
                                onPressed: () {
                                  todayDate();
                                },
                                child: Text(
                                  'Today',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: blueBackground),
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 9),
                            width: 115,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: button1,
                                ),
                                onPressed: () {
                                  tomorrowDate();
                                },
                                child: Text(
                                  'Tomorrow',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: blueBackground),
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 9),
                            width: 117,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: button1,
                                ),
                                onPressed: () {
                                  nextWeekDate();
                                },
                                child: Text(
                                  'Next Week',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: blueBackground),
                                )),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(
                  top: 10, left: 30, right: 20, bottom: 20),
              alignment: Alignment.centerLeft,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Note',
                        style: GoogleFonts.poppins(
                          height: 1.5,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: blueBackground,
                        )),
                    Container(
                      height: 40,
                      child: TextFormField(
                          controller: noteC,
                          style: TextStyle(
                              color: blackInput,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blueBackground),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blueBackground),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Priority',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: blueBackground,
                        )),
                    // TextFormField(
                    //     decoration: InputDecoration(
                    //   suffixIcon: Icon(
                    //     Icons.keyboard_arrow_down_rounded,
                    //     color: blueBackground,
                    //   ),
                    //   enabledBorder: UnderlineInputBorder(
                    //     borderSide: BorderSide(color: blueBackground),
                    //   ),
                    //   focusedBorder: UnderlineInputBorder(
                    //     borderSide: BorderSide(color: blueBackground),
                    //   ),
                    // )),
                    Container(
                      height: 45,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blueBackground),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blueBackground),
                          ),
                        ),
                        value: priority,
                        items: listPriority
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: blackInput,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            priority = value.toString();
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Reminder',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: blueBackground,
                        )),
                    Container(
                      height: 40,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blueBackground),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blueBackground),
                          ),
                        ),
                        value: reminder,
                        items: listReminder
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: blackInput,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != 'Custom') {
                            setState(() {
                              reminder = value.toString();
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Select Time',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF2756A5),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 50,
                                          child: TextField(
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                            keyboardType: TextInputType.number,
                                            controller: controller.hourC,
                                            textInputAction:
                                                TextInputAction.next,
                                            textAlign: TextAlign.center,
                                            maxLength: 2,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              counterText: '',
                                              hintText: 'HH',
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          width: 50,
                                          child: TextField(
                                            controller: controller.minC,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            textInputAction:
                                                TextInputAction.next,
                                            maxLength: 2,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              counterText: '',
                                              hintText: 'MM',
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          width: 50,
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: controller.secC,
                                            textAlign: TextAlign.center,
                                            textInputAction:
                                                TextInputAction.next,
                                            maxLength: 2,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              counterText: '',
                                              hintText: 'SS',
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Before',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Save')),
                                    ],
                                  );
                                });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        child: StreamBuilder<QuerySnapshot<Object?>>(
                            stream: controller.getDataLabel(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                var listlabel = snapshot.data!.docs;
                                List<String> listDataLabel = <String>["+"];
                                if (listlabel.isNotEmpty) {
                                  for (var element = 0;
                                      element < listlabel.length;
                                      element++) {
                                    var data = (listlabel[element].data()
                                        as Map<String, dynamic>)['label'];
                                    listDataLabel.add(data);
                                  }
                                }
                                return Wrap(
                                  spacing: 4.0, // gap between adjacent chips
                                  runSpacing: 0.0, // gap between lines
                                  children: listDataLabel
                                      .map((e) => GestureDetector(
                                            onLongPress: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                            actionsAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            actionsOverflowAlignment:
                                                                OverflowBarAlignment
                                                                    .center,
                                                            title: Text(
                                                                'Delete Label',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF2756A5),
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                            content: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12.0),
                                                              child: Text(
                                                                  'Are you sure want to delete this label?',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Color(
                                                                          0xFF262626))),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(
                                                                              horizontal:
                                                                                  25,
                                                                              vertical:
                                                                                  5)),
                                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                          )),
                                                                          backgroundColor: MaterialStateProperty.all<Color>(Color(
                                                                              0xFF9CC0FB))),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: const Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFF2756A5),
                                                                          fontWeight:
                                                                              FontWeight.w600))),
                                                              TextButton(
                                                                  style: ButtonStyle(
                                                                      padding: MaterialStateProperty.all<
                                                                          EdgeInsets>(const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              25,
                                                                          vertical:
                                                                              5)),
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20.0),
                                                                          side:
                                                                              BorderSide(color: Color(0xFF306BCE)))),
                                                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF306BCE))),
                                                                  onPressed: () {
                                                                    controller
                                                                        .deleteLabel(
                                                                            e.toString());
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: const Text(
                                                                    'Delete',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )),
                                                            ],
                                                          ));
                                            },
                                            child: ChoiceChip(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              backgroundColor: blueBackground,
                                              selectedColor:
                                                  const Color(0xFFD8E6FD),
                                              label: Text(
                                                e.toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: labelSelected == e
                                                      ? blueBackground
                                                      : const Color(0xFFD8E6FD),
                                                ),
                                              ),
                                              selected: labelSelected == e,
                                              onSelected: (value) {
                                                if (e.toString() != '+') {
                                                  setState(() {
                                                    labelSelected =
                                                        e.toString();
                                                  });
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    "Input Label",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xFF2756A5),
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                content:
                                                                    TextFormField(
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        controller:
                                                                            _labelController,
                                                                        style: TextStyle(
                                                                            color:
                                                                                blackInput,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight: FontWeight
                                                                                .w600),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          enabledBorder:
                                                                              UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: blueBackground),
                                                                          ),
                                                                          focusedBorder:
                                                                              UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: blueBackground),
                                                                          ),
                                                                        )),
                                                                actions: [
                                                                  TextButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                20,
                                                                            vertical:
                                                                                2)),
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        )),
                                                                        backgroundColor:
                                                                            MaterialStateColor.resolveWith((states) =>
                                                                                Color(0xFF9CC0FB)),
                                                                        foregroundColor:
                                                                            MaterialStateColor.resolveWith((states) =>
                                                                                Color(0xFF2756A5)),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Cancel',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )),
                                                                  TextButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                20,
                                                                            vertical:
                                                                                2)),
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        )),
                                                                        backgroundColor:
                                                                            MaterialStateColor.resolveWith((states) =>
                                                                                blueBackground),
                                                                        foregroundColor:
                                                                            MaterialStateColor.resolveWith((states) =>
                                                                                Colors.white),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        controller.addLabel(
                                                                            _labelController.text,
                                                                            uid);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'Add')),
                                                                ],
                                                                actionsAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                              ));
                                                }
                                              },
                                            ),
                                          ))
                                      .toList(),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            })),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF306BCE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        minimumSize: const Size.fromHeight(60), // NEW
                      ),
                      onPressed: () async {
                        controller.updateTask(
                            uid,
                            nameC.text,
                            _inputDate,
                            _inputTime,
                            noteC.text,
                            priority,
                            reminder,
                            false,
                            labelSelected,
                            widget.docId,
                            context);
                      },
                      child: Text(
                        'Update Task',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9CC0FB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        minimumSize: const Size.fromHeight(60), // NEW
                      ),
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  actionsAlignment: MainAxisAlignment.center,
                                  actionsOverflowAlignment:
                                      OverflowBarAlignment.center,
                                  title: Text('Delete Tasks',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFF2756A5),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                  content: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                        'Are you sure want to delete this task?',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF262626))),
                                  ),
                                  actions: [
                                    TextButton(
                                        style: ButtonStyle(
                                            padding:
                                                MaterialStateProperty.all<EdgeInsets>(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 5)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            )),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xFF9CC0FB))),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel',
                                            style: TextStyle(
                                                color: Color(0xFF2756A5),
                                                fontWeight: FontWeight.w600))),
                                    TextButton(
                                        style: ButtonStyle(
                                            padding:
                                                MaterialStateProperty.all<EdgeInsets>(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 5)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    side: BorderSide(
                                                        color: Color(0xFF306BCE)))),
                                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF306BCE))),
                                        onPressed: () {
                                          controller.deleteTasks(
                                            widget.docId,
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ],
                                ));
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Delete Task',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF2756A5),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
