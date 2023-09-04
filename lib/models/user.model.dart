
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? phone;
  String? uid;
  String? name;
  String? email;
  UserModel({
    this.phone,
    this.name,
    this.email,
    this.uid
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot docSnapshot}) {
    phone = docSnapshot["phone"];
    uid = docSnapshot.id;
    name = docSnapshot["name"];
    email = docSnapshot["email"];
  }

    Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = uid;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}


