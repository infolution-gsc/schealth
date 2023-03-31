//Dashboard

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:healthy_planner/database/database_helper.dart';
import 'package:healthy_planner/widget/listDaily.dart';

final dbHelper = DatabaseHelper();

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime dateTime = DateTime.now();
  final List<String> dayTime = <String>[
    '1 AM',
    '2 AM',
    '3 AM',
    '4 AM',
    '5 AM',
    '6 AM',
    '7 AM',
    '8 AM',
    '9 AM',
    '10 AM',
    '11 AM',
    '12 AM',
    '1 PM',
    '2 PM',
    '3 PM',
    '4 PM',
    '5 PM',
    '6 PM',
    '7 PM',
    '8 PM',
    '9 PM',
    '10 PM',
    '11 PM',
    '12 PM',
  ];

  bool status = true;

  int weekView = 1;
  double heightCalendar = 144;
  bool colorCalendar = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 30, top: 10),
                  child: FlutterSwitch(
                    value: status,
                    width: 60.0,
                    height: 30.0,
                    toggleSize: 25,
                    borderRadius: 26.0,
                    padding: 0.0,
                    toggleColor: const Color(0xFF306BCE),
                    activeColor: const Color(0xFFD8E6FD),
                    inactiveColor: const Color(0xFFD8E6FD),
                    valueFontSize: 10.0,
                    activeText: 'week',
                    inactiveText: 'day',
                    activeTextColor: const Color(0xFF306BCE),
                    inactiveTextColor: const Color(0xFF306BCE),
                    activeTextFontWeight: FontWeight.w600,
                    inactiveTextFontWeight: FontWeight.w600,
                    showOnOff: true,
                    activeIcon: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "day",
                        style: TextStyle(
                            color: Color(0xFFD8E6FD),
                            fontSize: 100,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    inactiveIcon: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "week",
                        style: TextStyle(
                            color: Color(0xFFD8E6FD),
                            fontSize: 100,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    onToggle: (val) {
                      setState(() {
                        status = val;
                        if (val == true) {
                          weekView = 1;
                          heightCalendar = 144;
                          colorCalendar = true;
                        } else {
                          weekView = 4;
                          colorCalendar = false;
                          heightCalendar = 300;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: heightCalendar,
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: SfCalendar(
                view: CalendarView.month,

                showNavigationArrow: true,
                todayHighlightColor: blueColor,
                //backgroundColor: colorCalendar ? Colors.transparent : button1,
                cellBorderColor: Colors.transparent,

                dataSource: MeetingDataSource(_getDataSource()),
                monthViewSettings: MonthViewSettings(
                  numberOfWeeksInView: weekView,
                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                  dayFormat: "E",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Today',
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 20),
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dayTime.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: index == 9 ? ListDaily() : Container(),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                dayTime[index],
                                style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ));
                    },
                  ),
                ],
              ),
            )
          ]),
        ));
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 5, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    //meetings.add(Meeting(
    //'Conference   5 PM - 7 PM', startTime, endTime, blueBackground, false));
    meetings.add(Meeting(
        'Yoga   9 PM - 11 PM',
        DateTime(today.year, today.month, today.day + 7, 9, 0, 0),
        DateTime(today.year, today.month, today.day + 7, 9, 0, 0)
            .add(const Duration(hours: 1)),
        button2,
        false));
    meetings.add(Meeting(
        'Yoga   9 PM - 11 PM',
        DateTime(today.year, today.month, today.day + 14, 9, 0, 0),
        DateTime(today.year, today.month, today.day + 14, 9, 0, 0)
            .add(const Duration(hours: 1)),
        button2,
        false));
    meetings.add(Meeting(
        'Yoga   9 PM - 11 PM',
        DateTime(today.year, today.month, today.day + 21, 9, 0, 0),
        DateTime(today.year, today.month, today.day + 21, 9, 0, 0)
            .add(const Duration(hours: 1)),
        button2,
        false));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
