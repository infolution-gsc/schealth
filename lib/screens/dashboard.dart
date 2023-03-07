//Dashboard

import 'package:flutter/material.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool calendarState = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                calendarState = false;
              },
              child: const Icon(Icons.calendar_view_week),
            ),
            Container(
              height: 800,
              child: SfCalendar(
                view: CalendarView.day,
                dataSource: MeetingDataSource(_getCalendarDataSource()),
                appointmentTextStyle: const TextStyle(
                    fontSize: 25,
                    color: Color(0xFFd89cf6),
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  List<Meeting> _getCalendarDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 15, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings
        .add(Meeting('Conference', startTime, endTime, blueBackground, false));
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
