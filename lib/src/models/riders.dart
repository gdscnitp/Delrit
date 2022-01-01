import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Rider {
  final String docId, uid;
  final GeoPoint source, destination;
  Rider({
    required this.docId,
    required this.uid,
    required this.source,
    required this.destination,
  });
}

RiderModel riderModelFromJson(Map<String, dynamic>? data) =>
    RiderModel.fromJson(data!);

String riderModelToJson(RiderModel data) => json.encode(data.toJson());

class RiderModel {
  RiderModel({
    required this.uid,
    required this.destination,
    required this.time,
    required this.source,
  });

  final String uid;
  final GeoPoint source, destination;
  final int time;

  factory RiderModel.fromJson(Map<String, dynamic> json) => RiderModel(
        uid: json["uid"],
        destination: json["destination"],
        time: json["time"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "destination": destination,
        "time": time,
        "source": source,
      };
}
