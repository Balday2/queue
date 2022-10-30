
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? phone;
  String? id;
  String? name;
  String? email;
  UserModel({
    this.phone,
    this.name,
    this.email,
    this.id
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot docSnapshot}) {
    phone = docSnapshot["phone"];
    id = docSnapshot.id;
    name = docSnapshot["name"];
    email = docSnapshot["email"];
  }
}


