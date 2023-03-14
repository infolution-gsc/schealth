//Dashboard

import 'package:flutter/material.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool status = true;
  CalendarController calendarController = CalendarController();
  CalendarView calendarView = CalendarView.day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 20, top: 10),
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
                              calendarView = CalendarView.day;
                              calendarController.view = calendarView;
                            } else {
                              calendarView = CalendarView.month;
                              calendarController.view = calendarView;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: blueColor,
                      selectedTextColor: Colors.white,
                      height: 96,
                      width: 67,
                      onDateChange: (date) {
                        // New date selected
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Container(
                  height: 500,
                  alignment: Alignment.center,
                  child: SfCalendar(
                    view: calendarView,
                    timeSlotViewSettings:
                        const TimeSlotViewSettings(timeIntervalHeight: 40),
                    controller: calendarController,
                    monthViewSettings: const MonthViewSettings(
                        showAgenda: true,
                        agendaViewHeight: 300,
                        agendaItemHeight: 60),
                    dataSource: MeetingDataSource(_getDataSource()),
                    appointmentTextStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 5, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference   5 PM - 7 PM', startTime, endTime, blueBackground, false));
    meetings.add(Meeting(
        'Yoga   9 PM - 11 PM',
        DateTime(today.year, today.month, today.day, 9, 0, 0),
        DateTime(today.year, today.month, today.day, 9, 0, 0)
            .add(const Duration(hours: 2)),
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
