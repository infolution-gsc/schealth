// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskController {
  TextEditingController dateC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController noteC = TextEditingController();
  TextEditingController hourC = TextEditingController();
  TextEditingController minC = TextEditingController();
  TextEditingController secC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addTask(
      String userID,
      String name,
      DateTime date,
      String time,
      String note,
      String priority,
      String reminder,
      bool complete,
      String category,
      BuildContext context) async {
    CollectionReference tasks = firestore.collection('tasks');

    try {
      await tasks.add({
        'user_id': userID,
        'name': name,
        'deadlineDate': date,
        'deadlineTime': time,
        'note': note,
        'priority': priority,
        'reminder': reminder,
        'complete': complete,
        'category': category,
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
                      child: const Text('OK'))
                ],
              ));
    }
  }

  Stream<QuerySnapshot<Object?>> getData(String category, String sortBy) {
    late String userId;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }

    CollectionReference tasks = firestore.collection('tasks');
    if (sortBy == 'Deadline') {
      if (category == 'All') {
        return tasks
            .where(
              'user_id',
              isEqualTo: userId,
            )
            .orderBy('deadlineDate', descending: false)
            .orderBy('priority', descending: false)
            .snapshots();
      } else {
        return tasks
            .where(
              'user_id',
              isEqualTo: userId,
            )
            .where("category", isEqualTo: category)
            .orderBy('deadlineDate', descending: false)
            .orderBy('priority', descending: false)
            // .orderBy('deadlineDate', descending: false)
            // .orderBy('priority', descending: false)
            .snapshots();
      }
    } else {
      if (category == 'All') {
        return tasks
            .where(
              'user_id',
              isEqualTo: userId,
            )
            .orderBy('priority', descending: false)
            .orderBy('deadlineDate', descending: false)
            // .orderBy('priority', descending: false)
            // .orderBy('deadlineDate', descending: false)
            .snapshots();
      } else {
        return tasks
            .where(
              'user_id',
              isEqualTo: userId,
            )
            .where("category", isEqualTo: category)
            .orderBy('priority', descending: false)
            .orderBy('deadlineDate', descending: false)
            // .orderBy('priority', descending: false)
            // .orderBy('deadlineDate', descending: false)
            .snapshots();
      }
    }
  }

  Future<void> updateComplete(bool complete, String docId) async {
    DocumentReference docData = firestore.collection('tasks').doc(docId);

    try {
      await docData.update({'complete': !complete});
    } catch (e) {
      print(e.toString());
    }
  }

  void addLabel(String label, String userId) {
    CollectionReference category = firestore.collection('category');

    try {
      category.add(
          {'user_id': userId, 'label': label, 'created_at': DateTime.now()});
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot<Object?>> getDataLabel() {
    late String userId;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }

    CollectionReference category = firestore.collection('category');
    return category
        .where(
          'user_id',
          isEqualTo: userId,
        )
        .snapshots();
  }
}
