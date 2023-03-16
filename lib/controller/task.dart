// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskController {
  TextEditingController dateC = TextEditingController();
  TextEditingController nameC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addTask(
      String name, DateTime date, bool complete, BuildContext context) async {
    CollectionReference tasks = firestore.collection('tasks');

    try {
      await tasks.add({
        'name': name,
        'deadline': date,
        'complete': complete,
        'created_at': DateTime.now()
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Success'),
                content: const Text("Berhasil menambahkan data"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'))
                ],
              ));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'))
                ],
              ));
    }
  }
}
