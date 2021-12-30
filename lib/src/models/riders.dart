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
