// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_planner/screens/auth/signin.dart';


class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {

  void _signOut() async {
    print('Signing Out...');
    try {
      await FirebaseAuth.instance.signOut();
      if(mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
      }
      print('User Signed Out');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _signOut,
       child: const Text('Logout')
     );
  }
}