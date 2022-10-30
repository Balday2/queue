
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queue/controllers/auth.controller.dart';

class AppConst {
  static const String userKey = 'mykey';
  static const String userRole = 'admin';
  static const String url = 'https://hello-world.com/api';
  static const String mapToken = 'AIzaSyDFiBVbZCRJFqy5l-7tAikalW9GVTG16Y8';

  // FIREBASE
  static final fireAuth = FirebaseAuth.instance;
  static final fireStore = FirebaseFirestore.instance;

  // CONTROLLERS
  static final authController = AuthController.instance;


  /// APP COLORS 
  static Color blue = Colors.blueAccent.withOpacity(0.8);
  static Color green = const Color(0xFF1fcecb);
  static Color yellow = const Color(0xFFFEE451);

}