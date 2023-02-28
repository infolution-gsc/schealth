// Home dart
// Main place for navigation between page

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/widget/add_daily.dart';
import 'package:healthy_planner/widget/add_task.dart';
import 'package:healthy_planner/screens/dashboard.dart';
import 'package:healthy_planner/screens/health.dart';
import 'package:healthy_planner/screens/profile.dart';
import 'package:healthy_planner/screens/timer.dart';
import 'package:healthy_planner/screens/task.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'expendable_fab.dart';
import 'action_button.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentTab = 0;
  final List<Widget> screens = [
    const Dashboard(),
    const Task(),
    const Health(),
    const Timer(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Card(
          margin: const EdgeInsets.only(top: 20),
          color: Colors.transparent,
          elevation: 0,
          child: Column(children: [
            MaterialButton(
              minWidth: 40,
              child: const CircleAvatar(
                foregroundImage: AssetImage('assets/illustration/student.png'),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Hi, Ji Eun",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
        ),
        centerTitle: true,
        actions: <Widget>[
          MaterialButton(
            minWidth: 20,
            onPressed: () {},
            child: const Image(
              image: AssetImage('assets/icon/Notifications.png'),
            ),
          )
        ],
        leading: MaterialButton(
          minWidth: 20,
          onPressed: () {},
          child: const Image(
            image: AssetImage('assets/icon/Menu.png'),
          ),
        ),
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: ExpandableFab(children: [
        ActionButton(
          icon: const Icon(
            Icons.calendar_today,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddDaily()),
            );
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.task,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTask()),
            );
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            print('add');
          },
        ),
      ], distance: 120),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = const Dashboard();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage('assets/icon/Dashboard.png'),
                      color: currentTab == 0 ? blueColor : Colors.grey,
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = const Task();
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage('assets/icon/Task.png'),
                      color: currentTab == 1 ? blueColor : Colors.grey,
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = const Health();
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage('assets/icon/Health.png'),
                      color: currentTab == 2 ? blueColor : Colors.grey,
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = const Timer();
                    currentTab = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage('assets/icon/Timer.png'),
                      color: currentTab == 3 ? blueColor : Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Profile()));
  }

  void _navigateToAddDaily(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddDaily()));
  }

  void _navigateToAddTask(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddTask()));
  }
}
