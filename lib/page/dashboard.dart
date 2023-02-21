//Dashboard

import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthy_planner/theme.dart';

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
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
              color: blueColor,
              padding: EdgeInsets.only(top: 30),
              iconSize: 50,
            ),
            Text("Hi, Ji Eun"),
          ]),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notification_add),
            color: blueColor,
          )
        ],
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
            color: blueColor,
          ),
        ),
      ),
      body: Center(
        child: Text('Dashboard'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            )),
      ),
    );
  }
}
