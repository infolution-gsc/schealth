import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'week_repeat.dart';

class AddDaily extends StatefulWidget {
  const AddDaily({super.key, this.restorationId});

  @override
  State<AddDaily> createState() => _AddDailyState();

  final String? restorationId;
}

class _AddDailyState extends State<AddDaily> with RestorationMixin {
  final dataController = TextEditingController();

  @override
  void dispose() {
    dataController.dispose();
    super.dispose();
  }

  bool pressAttention1 = true;
  bool pressAttention2 = true;
  bool pressAttention3 = true;
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }

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
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 30, right: 20),
                height: 400,
                decoration: BoxDecoration(
                    color: blueBackground,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          controller: dataController,
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor:
                                        pressAttention1 ? button1 : button2),
                                onPressed: () {
                                  setState(() {
                                    pressAttention1 = false;
                                    pressAttention2 = true;
                                    pressAttention3 = true;
                                  });
                                },
                                child: Text(
                                  'Study',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: pressAttention1
                                          ? blueColor
                                          : button1),
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: 100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor:
                                        pressAttention2 ? button1 : button2),
                                onPressed: () {
                                  setState(() {
                                    pressAttention1 = true;
                                    pressAttention2 = false;
                                    pressAttention3 = true;
                                  });
                                },
                                child: Text(
                                  'Work',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: pressAttention2
                                          ? blueColor
                                          : button1),
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: 100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor:
                                        pressAttention3 ? button1 : button2),
                                onPressed: () {
                                  setState(() {
                                    pressAttention1 = true;
                                    pressAttention2 = true;
                                    pressAttention3 = false;
                                  });
                                },
                                child: Text(
                                  'Others',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: pressAttention3
                                          ? blueColor
                                          : button1),
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
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 2),
                        child: DateTimeFormField(
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _restorableDatePickerRouteFuture.present();
                              },
                              icon: const Icon(Icons.calendar_month),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          checkColor: Colors.black,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                        ),
                        Text(
                          'Repeat',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                      ]),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Time',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
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
                      Text('Reminder',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: blueBackground,
                          )),
                      DropDownTextField(
                          controller: SingleValueDropDownController(),
                          clearOption: false,
                          validator: (value) {
                            if (value == null) {
                              return "Required field";
                            } else {
                              return null;
                            }
                          },
                          textFieldDecoration: InputDecoration(
                            suffixIconColor: blueColor,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blueBackground),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blueBackground),
                            ),
                          ),
                          dropdownRadius: 18,
                          listTextStyle: GoogleFonts.poppins(
                              fontSize: 16, color: blueColor),
                          dropdownColor: Colors.white,
                          searchDecoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: blueBackground))),
                          dropDownItemCount: 4,
                          dropDownList: const [
                            DropDownValueModel(
                                name: '5 Minutes Before', value: "value1"),
                            DropDownValueModel(
                                name: '10 Minutes Before', value: "value1"),
                            DropDownValueModel(
                                name: '15 Minutes Before', value: "value1"),
                            DropDownValueModel(name: 'Custom', value: "value1"),
                          ]),
                      const SizedBox(
                        height: 10,
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
                      Text('Location',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: blueBackground,
                          )),
                      TextFormField(
                          decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.location_pin,
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
                        height: 30,
                      ),
                      Center(
                        child: Container(
                          width: 310,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: blueColor,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Add Schedule',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
