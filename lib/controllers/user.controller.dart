
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/app/app.helpers.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/models/user.model.dart';

class UserController extends GetxController {
  final Rx<UserModel> _userModel = UserModel().obs;
  UserModel get user => _userModel.value;
  var token = "".obs;

  @override
  onInit(){
    super.onInit();
    token.value = AppHelper.getToken();
  }

  set user(UserModel value) => _userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }

  Future<bool> createNewUser(UserModel user) async {
    try {
      await AppConst.fireStore.collection("users").doc(user.id).set({
        "phone": user.phone,
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      debugPrint('[CREATE-USER-ERROR]: $e');
      return false;
    }
  }


  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await AppConst.fireStore.collection("users").doc(uid).get();
        return UserModel.fromDocumentSnapshot(docSnapshot: doc);
      } catch (e) {
        debugPrint('[Get-USER-ERROR]: $e');
        rethrow;
      }
  }
}