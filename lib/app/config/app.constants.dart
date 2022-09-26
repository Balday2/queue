
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppConst {
  static const String userKey = 'mykey';
  static const String userRole = 'admin';
  static const String url = 'https://hello-world.com/api';

  // FIREBASE
  static final fireAuth = FirebaseAuth.instance;
  // static final fireStorage = FirebaseStorage.instance;
  // static final fireStore = FirebaseFirestore.instance;

  // CONTROLLERS
  // static final authController = AuthController.instance;


  /// APP COLORS 
  static Color blue = Colors.blueAccent.withOpacity(0.8);
  static Color green = Colors.greenAccent.withOpacity(0.8);
}