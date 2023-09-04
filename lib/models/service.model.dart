
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceModel {
  String? documentId;
  late String name;
  late String address;
  late String description;
  late String phoneNumber;
  late LatLng location;
  late String distance;
  late String time;

  ServiceModel({
    this.documentId,
    required this.name,
    required this.address,
    required this.description,
    required this.phoneNumber,
    required this.location,
    required this.distance,
    required this.time,
  });

  ServiceModel.fromDocumentSnapshot({required DocumentSnapshot docSnapshot}){
    documentId = docSnapshot.id;
    name = docSnapshot['name'];
    address = docSnapshot['address'];
    distance = '0';
    time = '0';
    description = docSnapshot['description'];
    phoneNumber = docSnapshot['phoneNumber'];
    location = docSnapshot['location'];
  }
}
{
  'latitude': 222222,
  'long':
}
final locations = [
  const LatLng({"latitude": 9.600952908429162, "longitude": -13.64766251295805}),
  const LatLng({"latitude": 9.610069521009098, "longitude": -13.645762838423252}),
  const LatLng({"latitude": 9.606569085521244, "longitude": -13.644754998385906}),
  const LatLng({"latitude": 9.60736213286485, "longitude": -13.649661429226398}),
  const LatLng({"latitude": 9.604086131199178, "longitude": -13.646668754518032}),
  const LatLng({"latitude": 9.59463976330283, "longitude": -13.65808691829443}),
  const LatLng({"latitude": 9.586410712697031, "longitude": -13.65368977189064}),
];

final fakeServices = [
  ServiceModel(
    documentId: '001',
    name: 'Marcos',
    address: 'Address Marcoss 123',
    location: locations[0],
    distance: '0',
    description: 'Minim anim occaecat exercitation amet culpa commodo dolor magna labore fugiat.',
    time: '0',
    phoneNumber: '623078844'
  ),
  

  ServiceModel(
    documentId: '000',
    name: 'Station Lycée français',
    address: 'Ratoma/kipé',
    location: locations[1],
    distance: '0',
    description: 'Excepteur excepteur laborum sit aliqua consectetur sunt reprehenderit ad reprehenderit officia excepteur adipisicing nostrud ut.',
    time: '0',
    phoneNumber: '623078844'
  ),

  ServiceModel(
    documentId: '001',
    name: 'Longalkjd',
    address: 'Address Lkasdfoi 123',
    location: locations[2],
    distance: '0',
    description: 'Voluptate commodo ex ullamco amet consectetur sunt.',
    time: '0',
    phoneNumber: '623078844'
  ),

  ServiceModel(
    documentId: '002',
    name: 'Jhon ',
    address: 'Address Jhon Doe 233',
    location: locations[3],
    distance: '0',
    description: 'Ut et cillum ullamco cupidatat veniam occaecat tempor eu dolore aute cillum occaecat.',
    time: '0',
    phoneNumber: '623078844'
  ),

  ServiceModel(
    documentId: '003',
    name: 'Loiuasdfjk',
    address: 'Address Lovemalsdfkj yui',
    location: locations[4],
    distance: '0',
    description: 'Adipisicing labore in et consectetur enim non laborum laborum eu dolor nisi.',
    time: '0',
    phoneNumber: '623078844'
  ),

  ServiceModel(
    documentId: '004',
    name: 'Marcos',
    address: 'Address Lovladf ',
    location: locations[5],
    distance: '0',
    description: 'Eu in minim sit nisi eiusmod aliquip in nostrud aliquip.',
    time: '0',
    phoneNumber: '623078844'
  ),

  ServiceModel(
    documentId: '005',
    name: 'Marcos',
    address: 'Address Marcoss 123',
    location: locations[6],
    distance: '0',
    description: 'Incididunt duis consectetur est do exercitation duis magna enim ad cillum nulla irure cillum cupidatat.',
    time: '0',
    phoneNumber: '623078844'
  ),
];