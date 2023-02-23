//Dashboard

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthy_planner/theme.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Column(children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/illustration/student.png'),
            ),
            Text("Hi, Ji Eun"),
          ]),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notification_add),
            color: blueColor,
          )
        ],
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: blueColor,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: LiteRollingSwitch(
                value: true,
                colorOn: blueColor,
                colorOff: lightBlueColor,
                iconOn: Icons.menu,
                iconOff: Icons.volume_up,
                textSize: 20,
                textOn: "on",
                textOff: "off",
                onChanged: (bool position) {
                  print("the button $position");
                },
              ))
        ]),
      ),
    );
  }
}
