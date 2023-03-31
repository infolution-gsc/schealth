// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_planner/utils/theme.dart';

class DailyController {
  TextEditingController hourC = TextEditingController();
  TextEditingController minC = TextEditingController();
  TextEditingController secC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addDaily(
      String userID,
      String name,
      DateTime date,
      int category,
      int time,
      int reminder,
      String note,
      String location,
      bool complete,
      BuildContext context) async {
    CollectionReference daily = firestore.collection('daily');

    try {
      await daily.add({
        'user_id': userID,
        'name': name,
        'selectDate': date,
        'category': category,
        'time': time,
        'note': note,
        'reminder': reminder,
        'location': location,
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shadowColor: Color.fromARGB(0, 0, 0, 100),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                title: const Text(
                  'Success',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF2756A5), fontWeight: FontWeight.w600),
                ),
                content: const Text(
                  "Berhasil menambahkan data",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF262626), fontWeight: FontWeight.w500),
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xFF306BCE)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 26),
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ))
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

    CollectionReference tasks = firestore.collection('daily');
    if (sortBy == 'Deadline') {
      if (category == 'All') {
        return tasks
            .where(
              'user_id',
              isEqualTo: userId,
            )
            .orderBy('complete', descending: false)
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
            .orderBy('complete', descending: false)
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
            .orderBy('complete', descending: false)
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
            .orderBy('complete', descending: false)
            .orderBy('priority', descending: false)
            .orderBy('deadlineDate', descending: false)

            // .orderBy('priority', descending: false)
            // .orderBy('deadlineDate', descending: false)
            .snapshots();
      }
    }
  }

  Future<void> updateComplete(bool complete, String docId) async {
    DocumentReference docData = firestore.collection('daily').doc(docId);

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
