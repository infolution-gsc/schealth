// Home dart
// Main place for navigation between page

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/widget/add.dart';
import 'package:healthy_planner/screens/dashboard.dart';
import 'package:healthy_planner/screens/health.dart';
import 'package:healthy_planner/screens/profile.dart';
import 'package:healthy_planner/screens/timer.dart';
import 'package:healthy_planner/screens/task.dart';
import 'package:healthy_planner/utils/theme.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

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
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Add()));
            },
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

      /*
        body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const Dashboard();
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            })
            */
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Profile()));
  }

  void _navigateToAdd(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add()));
  }
}
