
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String? documentId;
  late String title;
  late String description;
  late String phoneNumber;
  late String location;

  ServiceModel({
    required this.title,
    required this.description,
    required this.phoneNumber,
    required this.location
  });

  ServiceModel.fromDocumentSnapshot({required DocumentSnapshot docSnapshot}){
    documentId = docSnapshot.id;
    title = docSnapshot['title'];
    description = docSnapshot['description'];
    phoneNumber = docSnapshot['phoneNumber'];
    location = docSnapshot['location'];
  }
}