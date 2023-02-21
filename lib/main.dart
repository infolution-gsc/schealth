// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/auth/signin.dart';
import 'package:healthy_planner/page/dashboard.dart';
import 'package:healthy_planner/page/home.dart';

void main() {
  runApp(const HealthyDailyPlanner());
}

class HealthyDailyPlanner extends StatelessWidget {
  const HealthyDailyPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/sigin': (context) => const SignIn(),
        '/home': (context) => const HomePage(),
        '/dashboard': (context) => const Dashboard(),
        // '/signup': (context) => SignUP(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}
