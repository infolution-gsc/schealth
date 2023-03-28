import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:healthy_planner/widget/countdown.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

List<String> listNote = [
  "Complete Task",
];

class _TimerState extends State<Timer> {
  bool status = true;
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text('Study',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF262626),
                              fontWeight: FontWeight.w700,
                            )),
                        IconButton(
                            onPressed: null, icon: Icon(Icons.arrow_drop_down)),
                      ],
                    ),
                    const Text(
                      '09:30 - 11.00',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Focus',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF132B52),
                          fontWeight: FontWeight.w600,
                        )),
                    Container(
                      width: 70,
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8E6FD),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 0),
                      child: FlutterSwitch(
                        width: 80.0,
                        height: 32.0,
                        toggleSize: 25,
                        value: status,
                        borderRadius: 26.0,
                        padding: 0.0,
                        toggleColor: const Color(0xFF306BCE),
                        activeColor: const Color(0xFFD8E6FD),
                        inactiveColor: const Color(0xFFD8E6FD),
                        valueFontSize: 10.0,
                        activeText: 'off',
                        inactiveText: 'on',
                        activeTextColor: const Color(0xFF306BCE),
                        inactiveTextColor: const Color(0xFF306BCE),
                        activeTextFontWeight: FontWeight.w600,
                        inactiveTextFontWeight: FontWeight.w600,
                        showOnOff: true,
                        activeIcon: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "on",
                            style: TextStyle(
                                color: Color(0xFFD8E6FD),
                                fontSize: 100,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        inactiveIcon: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "off",
                            style: TextStyle(
                                color: Color(0xFFD8E6FD),
                                fontSize: 100,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        onToggle: (val) {
                          setState(() {
                            status = val;
                          });
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const CountdownPage(),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Column(children: [
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listNote.length,
                itemBuilder: (context, index) {
                  var doc = listNote[index];
                  return Row(
                    children: [
                      Image.asset('assets/icon/dotNote.png'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(doc.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF262626),
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Add Notes",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF2756A5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            content: TextFormField(
                                textAlign: TextAlign.center,
                                controller: _noteController,
                                style: TextStyle(
                                    color: blackInput,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: blueBackground),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: blueBackground),
                                  ),
                                )),
                            actions: [
                              TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 2)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    )),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Color(0xFF9CC0FB)),
                                    foregroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Color(0xFF2756A5)),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )),
                              TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 2)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    )),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => blueBackground),
                                    foregroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      listNote.add(_noteController.text);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Add')),
                            ],
                            actionsAlignment: MainAxisAlignment.center,
                          ));
                },
                child: Row(
                  children: [
                    Image.asset('assets/icon/addDot.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Add Notes",
                        style: TextStyle(
                          fontSize: 14,
                          color: blueBackground,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
