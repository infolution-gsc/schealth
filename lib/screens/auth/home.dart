// Home dart

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthy_planner/screens/auth/signin.dart';
import 'package:healthy_planner/screens/start/fisrt.dart';
import 'package:healthy_planner/screens/start/letsstart.dart';
import 'package:healthy_planner/widget/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLogin = false;

  checkIfLogin() async {
    var auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Navigation()));
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkIfLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const LetsStart());
  }
}
