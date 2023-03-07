import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FirstStart extends StatefulWidget {
  const FirstStart({super.key});

  @override
  State<FirstStart> createState() => _FirstStartState();
}

class _FirstStartState extends State<FirstStart> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('assets/illustration/first.png'));
  }
}
