import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/database/database_helper.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

final dbHelper = DatabaseHelper();

class AddDaily extends StatefulWidget {
  const AddDaily({super.key, this.restorationId});

  @override
  State<AddDaily> createState() => _AddDailyState();

  final String? restorationId;
}

class _AddDailyState extends State<AddDaily> {
  bool pressAttention1 = true;
  bool pressAttention2 = true;
  bool pressAttention3 = true;
  bool pressAttentionDay1 = true;
  bool pressAttentionDay2 = true;
  bool pressAttentionDay3 = true;
  bool pressAttentionDay4 = true;
  bool pressAttentionDay5 = true;
  bool pressAttentionDay6 = true;
  bool pressAttentionDay7 = true;
  double dayButtonWidth = 48;
  double dayButtonFontSize = 16;
  double containerTopHeight = 360;
  int reminderValue = 0;
  int timeFormat = 0;
  TextEditingController timeFormatController = TextEditingController();
  TextEditingController datePickerController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  int category = 0;

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
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 20),
            height: containerTopHeight,
            decoration: BoxDecoration(
                color: blueBackground,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Name',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              TextFormField(
                  style: GoogleFonts.poppins(color: Colors.white),
                  controller: nameController,
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
                                borderRadius: BorderRadius.circular(10)),
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
                              color: pressAttention1 ? blueColor : button1),
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: 100,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
                              color: pressAttention2 ? blueColor : button1),
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: 100,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
                              color: pressAttention3 ? blueColor : button1),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              /*
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
                    right: MediaQuery.of(context).size.width / 2 + 10),
                child: TextFormField(
                    onTap: () {
                      _restorableDatePickerRouteFuture.present();
                    },
                    controller: datePickerController,
                    style: GoogleFonts.poppins(color: Colors.white),
                    decoration: InputDecoration(
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
                        icon: const Icon(Icons.calendar_month_rounded),
                        color: Colors.white,
                      ),
                    )),
              ),
              
              Row(children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                      isChecked
                          ? containerTopHeight = 410
                          : containerTopHeight = 330;
                    });
                  },
                  checkColor: Colors.black,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                ),
                Text(
                  'Repeat',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ]),
              */
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequency',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: dayButtonWidth,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: const EdgeInsets.only(
                                      right: 0, left: 0, top: 6, bottom: 6),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      pressAttentionDay1 ? button1 : button2),
                              onPressed: () {
                                setState(() {
                                  pressAttentionDay1
                                      ? pressAttentionDay1 = false
                                      : pressAttentionDay1 = true;
                                });
                              },
                              child: Text(
                                'Mon',
                                style: GoogleFonts.poppins(
                                    fontSize: dayButtonFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: pressAttentionDay1
                                        ? blueColor
                                        : button1),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          width: dayButtonWidth,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: const EdgeInsets.only(
                                      right: 0, left: 0, top: 6, bottom: 6),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      pressAttentionDay2 ? button1 : button2),
                              onPressed: () {
                                setState(() {
                                  pressAttentionDay2
                                      ? pressAttentionDay2 = false
                                      : pressAttentionDay2 = true;
                                });
                              },
                              child: Text(
                                'Tue',
                                style: GoogleFonts.poppins(
                                    fontSize: dayButtonFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: pressAttentionDay2
                                        ? blueColor
                                        : button1),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          width: dayButtonWidth,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: const EdgeInsets.only(
                                      right: 0, left: 0, top: 6, bottom: 6),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      pressAttentionDay3 ? button1 : button2),
                              onPressed: () {
                                setState(() {
                                  pressAttentionDay3
                                      ? pressAttentionDay3 = false
                                      : pressAttentionDay3 = true;
                                });
                              },
                              child: Text(
                                'Wed',
                                style: GoogleFonts.poppins(
                                    fontSize: dayButtonFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: pressAttentionDay3
                                        ? blueColor
                                        : button1),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          width: dayButtonWidth,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: const EdgeInsets.only(
                                      right: 0, left: 0, top: 6, bottom: 6),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      pressAttentionDay4 ? button1 : button2),
                              onPressed: () {
                                setState(() {
                                  pressAttentionDay4
                                      ? pressAttentionDay4 = false
                                      : pressAttentionDay4 = true;
                                });
                              },
                              child: Text(
                                'Thu',
                                style: GoogleFonts.poppins(
                                    fontSize: dayButtonFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: pressAttentionDay4
                                        ? blueColor
                                        : button1),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          width: dayButtonWidth,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: const EdgeInsets.only(
                                      right: 0, left: 0, top: 6, bottom: 6),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      pressAttentionDay5 ? button1 : button2),
                              onPressed: () {
                                setState(() {
                                  pressAttentionDay5
                                      ? pressAttentionDay5 = false
                                      : pressAttentionDay5 = true;
                                });
                              },
                              child: Text(
                                'Fri',
                                style: GoogleFonts.poppins(
                                    fontSize: dayButtonFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: pressAttentionDay5
                                        ? blueColor
                                        : button1),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          width: dayButtonWidth,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: const EdgeInsets.only(
                                      right: 0, left: 0, top: 6, bottom: 6),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      pressAttentionDay6 ? button1 : button2),
                              onPressed: () {
                                setState(() {
                                  pressAttentionDay6
                                      ? pressAttentionDay6 = false
                                      : pressAttentionDay6 = true;
                                });
                              },
                              child: Text(
                                'Sat',
                                style: GoogleFonts.poppins(
                                    fontSize: dayButtonFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: pressAttentionDay6
                                        ? blueColor
                                        : button1),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          width: dayButtonWidth,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: const EdgeInsets.only(
                                      right: 0, left: 0, top: 6, bottom: 6),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      pressAttentionDay7 ? button1 : button2),
                              onPressed: () {
                                setState(() {
                                  pressAttentionDay7
                                      ? pressAttentionDay7 = false
                                      : pressAttentionDay7 = true;
                                });
                              },
                              child: Text(
                                'Sun',
                                style: GoogleFonts.poppins(
                                    fontSize: dayButtonFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: pressAttentionDay7
                                        ? blueColor
                                        : button1),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                'Time',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.poppins(color: Colors.white),
                  controller: timeFormatController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  )),
            ]),
          ),
          Container(
            color: Colors.transparent,
            padding:
                const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
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
                          reminderValue = int.parse(value);
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
                      listTextStyle:
                          GoogleFonts.poppins(fontSize: 16, color: blueColor),
                      dropdownColor: Colors.white,
                      searchDecoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: blueBackground))),
                      dropDownItemCount: 4,
                      dropDownList: const [
                        DropDownValueModel(name: '5 Minutes Before', value: 5),
                        DropDownValueModel(
                            name: '10 Minutes Before', value: 10),
                        DropDownValueModel(
                            name: '15 Minutes Before', value: 15),
                        DropDownValueModel(name: 'Custom', value: "5"),
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
                      controller: noteController,
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
                      controller: locationController,
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
                      width: 300,
                      height: 54,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(blueBackground),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )),
                        ),
                        onPressed: () {
                          setState(() {
                            final id = dbHelper.insert(Daily(
                                name: nameController.text,
                                category: category,
                                sun: pressAttentionDay1,
                                mon: pressAttentionDay2,
                                tue: pressAttentionDay3,
                                wed: pressAttentionDay4,
                                thu: pressAttentionDay5,
                                fri: pressAttentionDay6,
                                sat: pressAttentionDay7,
                                reminder: reminderValue,
                                note: noteController.text,
                                location: locationController.text));
                            if (id != null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('success'),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Enable'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                            pressAttention1 = true;
                            pressAttention2 = true;
                            pressAttention3 = true;
                            timeFormat = int.parse(timeFormatController.text);
                          });
                        },
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
    );
  }
}
