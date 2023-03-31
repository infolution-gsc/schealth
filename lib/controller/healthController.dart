// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HealthController {
  TextEditingController hourC = TextEditingController();
  TextEditingController minC = TextEditingController();
  TextEditingController secC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getData(String category) {
    var query = "eat-healthy";
    if (category == "eat-healthy") {
      query = "eat-healthy";
    } else if (category == "Healthy From Mind") {
      query = "healthy-from-mind";
    } else if (category == "Everyday Simple Yoga") {
      query = "everyday-simple-yoga";
    } else if (category == "Better Sleep") {
      query = "better-sleep";
    }

    CollectionReference health = firestore.collection(query);
    return health.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getDataLabel() {
    CollectionReference category = firestore.collection('categoryHealth');
    return category.snapshots();
  }
}
