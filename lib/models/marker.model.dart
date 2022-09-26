import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:queue/app/config/app.asset.dart';

class MarkerModel {
  const MarkerModel({
    required this.image,
    required this.title,
    required this.address,
    required this.location,
  });

  final String image;
  final String title;
  final String address;
  final LatLng location;
}

final locations = [
  const LatLng(37.7880041, -122.4068237),
  const LatLng(37.7830962, -122.4068307),
  const LatLng(37.7880045, -122.40605112),
  const LatLng(37.7854067, -122.4067675),
  const LatLng(37.7838438, -122.4062122),
  const LatLng(37.7811287, -122.4062137),
  const LatLng(37.7822444, -122.4068716),
];

final mapMarkers = [
  MarkerModel(
    image: AppAsset.mapPin,
    title: 'Marcos',
    address: 'Address Marcoss 123',
    location: locations[0],
  ),
  

  MarkerModel(
    image: AppAsset.mapPin,
    title: 'Ljasdin',
    address: 'Address Loasdjf 84n',
    location: locations[1],
  ),

  MarkerModel(
    image: AppAsset.mapPin,
    title: 'Longalkjd',
    address: 'Address Lkasdfoi 123',
    location: locations[2],
  ),

  MarkerModel(
    image: AppAsset.mapPin,
    title: 'Jhon ',
    address: 'Address Jhon Doe 233',
    location: locations[3],
  ),

  MarkerModel(
    image: AppAsset.mapPin,
    title: 'Loiuasdfjk',
    address: 'Address Lovemalsdfkj yui',
    location: locations[4],
  ),

  MarkerModel(
    image: AppAsset.mapPin,
    title: 'Marcos',
    address: 'Address Lovladf ',
    location: locations[5],
  ),

  MarkerModel(
    image: AppAsset.mapPin,
    title: 'Marcos',
    address: 'Address Marcoss 123',
    location: locations[6],
  ),
];