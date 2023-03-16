import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/controller/task.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:date_field/date_field.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key, this.restorationId});

  @override
  State<AddTask> createState() => _AddTaskState();

  final String? restorationId;
}

class _AddTaskState extends State<AddTask> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  late DateTime _inputDate;
  late String _inputForm;
  final TaskController controller = TaskController();

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

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        setState(() {
          _inputDate = _selectedDate.value;
          _inputForm =
              '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
          controller.dateC.text = _inputForm;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  void todayDate() {
    setState(() {
      _selectedDate.value = DateTime.now();
      _inputDate = _selectedDate.value;
      _inputForm =
          '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      controller.dateC.text = _inputForm;
    });
  }

  void tomorrowDate() {
    setState(() {
      _selectedDate.value = DateTime.now().add(const Duration(days: 1));
      _inputDate = _selectedDate.value;
      _inputForm =
          '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      controller.dateC.text = _inputForm;
    });
  }

  void nextWeekDate() {
    setState(() {
      _selectedDate.value = DateTime.now().add(const Duration(days: 7));
      _inputDate = _selectedDate.value;
      _inputForm =
          '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      controller.dateC.text = _inputForm;
    });
  }

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
            'Add Task',
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
              height: 275,
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
                    TextFormField(
                        controller: controller.nameC,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Date',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 2.5),
                      child: TextFormField(
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        controller: controller.dateC,
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
                      height: 20,
                    ),
                    Text('Note',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: blueBackground,
                        )),
                    TextFormField(
                        decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: blueBackground),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: blueBackground),
                      ),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Priority',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: blueBackground,
                        )),
                    TextFormField(
                        decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: blueBackground,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: blueBackground),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: blueBackground),
                      ),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Reminder',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: blueBackground,
                        )),
                    TextFormField(
                        decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: blueBackground,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: blueBackground),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: blueBackground),
                      ),
                    )),
                    const SizedBox(
                      height: 100,
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
                        controller.addTask(
                            controller.nameC.text, _inputDate, false, context);
                      },
                      child: Text(
                        'Add Task',
                        style: GoogleFonts.poppins(
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
