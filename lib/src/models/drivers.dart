import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// class Driver {
//   final String docId, uid;
//   final String name;
//   final DateTime timestamp;
//   final GeoPoint source, destination;
//   late String sourceName, destinationName;
//   Driver({
//     required this.docId,
//     required this.uid,
//     required this.name,
//     required this.timestamp,
//     required this.source,
//     required this.destination,
//   });

//   setSourceName(String name) {
//     sourceName = name;
//   }

//   setDestionaName(String name) {
//     destinationName = name;
//   }
// }

DriverModel driverModelFromJson(Map<String, dynamic>? data) =>
    DriverModel.fromJson(data!);

String driverModelToJson(DriverModel data) => json.encode(data.toJson());

class DriverModel {
  DriverModel({
    required this.destination,
    required this.source,
    required this.time,
    required this.uid,
    required this.vehicle,
  });

  final GeoPoint destination, source;
  final int time;
  final String? uid;
  final String vehicle;
  late String sourceName, destinationName;

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        destination: json["destination"],
        source: json["source"],
        time: json["time"],
        uid: json["uid"],
        vehicle: json["vehicle"],
      );

  Map<String, dynamic> toJson() => {
        "destination": destination,
        "source": source,
        "time": time,
        "uid": uid,
        "vehicle": vehicle,
      };

  setSourceName(String name) {
    sourceName = name;
  }

  setDestinationName(String name) {
    destinationName = name;
  }
}
