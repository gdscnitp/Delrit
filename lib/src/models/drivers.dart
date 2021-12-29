import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  final String docId, uid;
  final String name;
  final DateTime timestamp;
  final GeoPoint source, destination;
  Driver({
    required this.docId,
    required this.uid,
    required this.name,
    required this.timestamp,
    required this.source,
    required this.destination,
  });
}
