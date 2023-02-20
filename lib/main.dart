import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/auth/signin.dart';

void main() {
  runApp(const HealthyDailyPlanner());
}

class HealthyDailyPlanner extends StatelessWidget {
  const HealthyDailyPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignIn(),
      routes: {
        '/sigin': (context) => const SignIn(),
        // '/signup': (context) => SignUP(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}
