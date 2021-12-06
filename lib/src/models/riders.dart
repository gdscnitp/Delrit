import 'package:cloud_firestore/cloud_firestore.dart';

class Rider {
  final String id;
  final String name;
  final GeoPoint source, destination;
  Rider({
    required this.id,
    required this.name,
    required this.source,
    required this.destination,
  });
}
