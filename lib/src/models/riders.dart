import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

RiderModel riderModelFromJson(Map<String, dynamic>? data, String id) =>
    RiderModel.fromJson(data!, id);

String riderModelToJson(RiderModel data) => json.encode(data.toJson());

class RiderModel {
  RiderModel({
    required this.uid,
    required this.destination,
    required this.time,
    required this.source,
    required this.docId,
  });

  final String uid, docId;
  final GeoPoint source, destination;
  final int time;
  // final String docId;
  late String sourceName, destinationName;

  set setSourceName(String name) => sourceName = name;
  set setDestinationName(String name) => destinationName = name;

  factory RiderModel.fromJson(Map<String, dynamic> json, String id) =>
      RiderModel(
        uid: json["uid"],
        destination: json["destination"],
        time: json["time"],
        source: json["source"],
        docId: id,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "destination": destination,
        "time": time,
        "source": source,
      };
}
