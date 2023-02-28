import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/utils/theme.dart';

class AddDaily extends StatefulWidget {
  const AddDaily({super.key, this.restorationId});

  @override
  State<AddDaily> createState() => _AddDailyState();

  final String? restorationId;
}

class _AddDailyState extends State<AddDaily> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2023, 2, 27));
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
          firstDate: DateTime(2022),
          lastDate: DateTime(2025),
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

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

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
            'Add Daily Schedule',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: blueBackground,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Name',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                TextFormField(
                    decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Linear Algebra Class',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Category',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: button1,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Study',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: blueBackground),
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: button1,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Work',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: blueBackground),
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: button1,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Others',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: blueBackground),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Date',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 100,
                  child: TextFormField(
                      decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    suffix: IconButton(
                      onPressed: () {
                        _restorableDatePickerRouteFuture.present();
                      },
                      icon: const Icon(Icons.calendar_month),
                      color: Colors.white,
                    ),
                  )),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Checkbox(
                      value: false,
                      onChanged: (value) {},
                      checkColor: Colors.white,
                    )),
              ]),
        ),
      ),
    );
  }
}
