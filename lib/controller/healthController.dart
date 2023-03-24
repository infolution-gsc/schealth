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
    var query = "lifestyle";
    if (category == "Lifestyle") {
      query = "lifestyle";
    } else if (category == "Sleep Hygiene") {
      query = "sleep-hygiene";
    } else if (category == "Mental Health") {
      query = "mental";
    }

    CollectionReference health = firestore.collection(query);
    return health.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getDataLabel() {
    CollectionReference category = firestore.collection('categoryHealth');
    return category.snapshots();
  }
}
