// Home dart
// Main place for navigation between page

// ignore_for_file: depend_on_referenced_packages, sort_child_properties_last, prefer_const_constructors

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/controller/noti.dart';
import 'package:healthy_planner/widget/add/add_daily.dart';
import 'package:healthy_planner/widget/add/add_habit.dart';
import 'package:healthy_planner/widget/add/add_task.dart';
import 'package:healthy_planner/screens/dashboard.dart';
import 'package:healthy_planner/screens/health.dart';
import 'package:healthy_planner/screens/profile.dart';
import 'package:healthy_planner/screens/timer.dart';
import 'package:healthy_planner/screens/task.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {
  int currentTab = 0;
  final List<Widget> screens = [
    const Dashboard(),
    const Task(),
    const Health(),
    const Timer(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Dashboard();

  String? name;
  String? photoUrl;
  late AnimationController _controller;
  late Animation _animation;
  var auth = FirebaseAuth.instance;

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          name = user.displayName.toString();
          photoUrl = user.photoURL.toString();
        }
      } else {
        name = 'Fellas';
        photoUrl = null;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Notif.initialize(flutterLocalNotificationsPlugin);

    name = 'Fellas';
    photoUrl = null;

    checkIfLogin();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      reverseDuration: Duration(milliseconds: 275),
    );

    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn);

    _controller.addListener(() {
      setState(() {});
    });
  }

  bool toogle = true;
  bool textshow = false;
  Alignment alignment1 = Alignment(0, 0);
  Alignment alignment2 = Alignment(0, 0);
  Alignment alignment3 = Alignment(0, 0);
  // Offset offset2 = Offset(0, -30);
  double size1 = 50;
  double size2 = 50;
  double size3 = 50;
  bool refresh = true;

  Future<void> refreshPage() {
    setState(() {
      refresh = !refresh;
    });
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.transparent,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
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
                child: CircleAvatar(
                  backgroundImage: photoUrl == null
                      ? NetworkImage(photoUrl!)
                      : AssetImage('assets/illustration/student.png')
                          as ImageProvider,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              currentTab == 0
                  ? Text(
                      name == "null" ? 'Hi, Fellas' : 'Hi, $name',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const SizedBox(
                      height: 5,
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
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: PageStorage(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/bg/bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(child: currentScreen),
                toogle
                    ? Container()
                    : BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                              colors: const [
                                Colors.white60,
                                Colors.white10,
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            bucket: bucket,
          ),
        ),
        bottomNavigationBar: Container(
          height: toogle ? 80 : 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: toogle ? 0 : 100,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(50, 0, 0, 0),
                                spreadRadius: 0,
                                blurRadius: 37),
                          ],
                        ),
                        height: 80,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          child: BottomNavigationBar(
                              elevation: 0,
                              currentIndex: 0,
                              onTap: (index) {
                                setState(() {
                                  currentScreen = screens[index];
                                  currentTab = index;
                                });
                              },
                              type: BottomNavigationBarType.fixed,
                              backgroundColor: Color(0xFFF5F5F5),
                              showSelectedLabels: false,
                              selectedItemColor: Color(0xFF306BCE),
                              unselectedItemColor: Color(0xFFE0E0E0),
                              showUnselectedLabels: false,
                              items: <BottomNavigationBarItem>[
                                BottomNavigationBarItem(
                                    icon: Image.asset(
                                        'assets/icon/Dashboard.png',
                                        color: currentTab == 0
                                            ? blueColor
                                            : Color(0xFfE0E0E0)),
                                    label: 'Dashboard'),
                                BottomNavigationBarItem(
                                    icon: Transform.translate(
                                      offset: Offset(-20, 0),
                                      child: Image.asset(
                                        'assets/icon/Task.png',
                                        color: currentTab == 1
                                            ? blueColor
                                            : Color(0xFfE0E0E0),
                                      ),
                                    ),
                                    label: 'Task'),
                                BottomNavigationBarItem(
                                    icon: Transform.translate(
                                      offset: Offset(20, 0),
                                      child: Image.asset(
                                        'assets/icon/Health.png',
                                        color: currentTab == 2
                                            ? blueColor
                                            : Color(0xFfE0E0E0),
                                      ),
                                    ),
                                    label: 'Health'),
                                BottomNavigationBarItem(
                                    icon: Image.asset(
                                      'assets/icon/Timer.png',
                                      color: currentTab == 3
                                          ? blueColor
                                          : Color(0xFfE0E0E0),
                                    ),
                                    label: 'Timer'),
                              ]),
                          // child: BottomAppBar(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: <Widget>[
                          //       MaterialButton(
                          //         minWidth: 40,
                          //         onPressed: () {
                          //           setState(() {
                          //             currentScreen = const Dashboard();
                          //             currentTab = 0;
                          //           });
                          //         },
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Image(
                          //               image: const AssetImage(
                          //                   'assets/icon/Dashboard.png'),
                          //               color: currentTab == 0
                          //                   ? blueColor
                          //                   : Colors.grey,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       MaterialButton(
                          //         minWidth: 40,
                          //         onPressed: () {
                          //           setState(() {
                          //             currentScreen = const Task();
                          //             currentTab = 1;
                          //           });
                          //         },
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Image(
                          //               image: const AssetImage(
                          //                   'assets/icon/Task.png'),
                          //               color: currentTab == 1
                          //                   ? blueColor
                          //                   : Colors.grey,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       MaterialButton(
                          //         minWidth: 40,
                          //         onPressed: () {
                          //           setState(() {
                          //             currentScreen = const Health();
                          //             currentTab = 2;
                          //           });
                          //         },
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Image(
                          //               image: const AssetImage(
                          //                   'assets/icon/Health.png'),
                          //               color: currentTab == 2
                          //                   ? blueColor
                          //                   : Colors.grey,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       MaterialButton(
                          //         minWidth: 40,
                          //         onPressed: () {
                          //           setState(() {
                          //             currentScreen = const Timer();
                          //             currentTab = 3;
                          //           });
                          //         },
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Image(
                          //               image: const AssetImage(
                          //                   'assets/icon/Timer.png'),
                          //               color: currentTab == 3
                          //                   ? blueColor
                          //                   : Colors.grey,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: toogle ? 80 : 180,
                    child: Stack(
                      children: [
                        Transform.translate(
                          offset: toogle
                              ? const Offset(0, -30)
                              : const Offset(0, 0),
                          child: AnimatedAlign(
                            duration: toogle
                                ? Duration(milliseconds: 275)
                                : Duration(milliseconds: 875),
                            alignment: alignment1,
                            curve: toogle ? Curves.easeIn : Curves.elasticOut,
                            child: AnimatedContainer(
                                duration: toogle
                                    ? Duration(milliseconds: 275)
                                    : Duration(milliseconds: 875),
                                curve: toogle ? Curves.easeIn : Curves.easeOut,
                                height: size1,
                                width: size1,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF7970),
                                  borderRadius: BorderRadius.circular(50.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/icon/daily.png',
                                        width: 40,
                                        height: 40,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddDaily()),
                                        );
                                      },
                                    ),
                                    textshow
                                        ? Transform.translate(
                                            offset: const Offset(0, -10),
                                            child: Text(
                                              'Daily',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Color(0xFFB42318),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        : Transform.translate(
                                            offset: Offset(0, -30),
                                            child: const SizedBox()),
                                  ],
                                )),
                          ),
                        ),
                        Transform.translate(
                          offset: toogle
                              ? const Offset(0, -30)
                              : const Offset(0, 0),
                          child: AnimatedAlign(
                            duration: toogle
                                ? Duration(milliseconds: 275)
                                : Duration(milliseconds: 875),
                            alignment: alignment2,
                            curve: toogle ? Curves.easeIn : Curves.elasticOut,
                            child: AnimatedContainer(
                                duration: toogle
                                    ? Duration(milliseconds: 275)
                                    : Duration(milliseconds: 875),
                                curve: toogle ? Curves.easeIn : Curves.easeOut,
                                height: size2,
                                width: size2,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFEC87F),
                                  borderRadius: BorderRadius.circular(50.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/icon/taskFloat.png',
                                        width: 40,
                                        height: 40,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddTask()),
                                        );
                                      },
                                    ),
                                    textshow
                                        ? Transform.translate(
                                            offset: const Offset(0, -10),
                                            child: Text(
                                              'Task',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Color(0xFFF79009),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        : Transform.translate(
                                            offset: Offset(0, -30),
                                            child: const SizedBox()),
                                  ],
                                )),
                          ),
                        ),
                        Transform.translate(
                          offset: toogle
                              ? const Offset(0, -30)
                              : const Offset(0, 0),
                          child: AnimatedAlign(
                            duration: toogle
                                ? Duration(milliseconds: 275)
                                : Duration(milliseconds: 875),
                            alignment: alignment3,
                            curve: toogle ? Curves.easeIn : Curves.elasticOut,
                            child: AnimatedContainer(
                                duration: toogle
                                    ? Duration(milliseconds: 275)
                                    : Duration(milliseconds: 875),
                                curve: toogle ? Curves.easeIn : Curves.easeOut,
                                height: size3,
                                width: size3,
                                decoration: BoxDecoration(
                                  color: Color(0xFF6CE9A6),
                                  borderRadius: BorderRadius.circular(50.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/icon/healthFloat.png',
                                        width: 40,
                                        height: 40,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddHabit()),
                                        );
                                      },
                                    ),
                                    textshow
                                        ? Transform.translate(
                                            offset: const Offset(0, -10),
                                            child: Text(
                                              'Health',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Color(0xFF12B76A),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        : Transform.translate(
                                            offset: Offset(0, -30),
                                            child: const SizedBox()),
                                  ],
                                )),
                          ),
                        ),
                        Transform.translate(
                          offset: toogle
                              ? const Offset(0, -35)
                              : const Offset(0, 20),
                          child: Align(
                            alignment: Alignment.center,
                            child: Transform.rotate(
                              angle: _animation.value * pi * (3 / 4),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 375),
                                curve: Curves.easeOut,
                                height: toogle ? 70.0 : 60.0,
                                width: toogle ? 70.0 : 60.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF306BCE),
                                  borderRadius: BorderRadius.circular(50.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      splashColor: Colors.black54,
                                      splashRadius: 31.0,
                                      onPressed: () {
                                        setState(() {
                                          if (toogle) {
                                            _controller.forward();
                                            toogle = !toogle;
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 10), () {
                                              setState(() {
                                                alignment1 =
                                                    Alignment(-0.5, -0.4);
                                                size1 = 70;
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 550), () {
                                                  setState(() {
                                                    textshow = true;
                                                  });
                                                });
                                              });
                                            });
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 10), () {
                                              setState(() {
                                                alignment2 = Alignment(0.0, -1);
                                                size2 = 70;
                                                // offset2 = Offset(0, -100);
                                              });
                                            });
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 10), () {
                                              setState(() {
                                                alignment3 =
                                                    Alignment(0.5, -0.4);
                                                size3 = 70;
                                              });
                                            });
                                          } else {
                                            _controller.reverse();
                                            toogle = !toogle;
                                            alignment1 = Alignment(0, 0);
                                            alignment2 = Alignment(0, 0);
                                            alignment3 = Alignment(0, 0);
                                            textshow = false;
                                            size1 = 50;
                                            size2 = 50;
                                            size3 = 50;
                                            // offset2 = Offset(0, -30);
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Profile()));
  }

  void _navigateToAddDaily(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => AddDaily()));
  }

  void _navigateToAddTask(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => AddTask()));
  }

  String nameSearch(String name) {
    this.name = name;
    String nameReturn;
    name.isEmpty ? nameReturn = 'Hi, Fellas' : nameReturn = 'Hi, $name';
    return nameReturn;
  }
}
