import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/services/api_response.dart';
import 'package:ride_sharing/services/api_services.dart';
import 'package:ride_sharing/src/models/riders.dart';
import 'package:ride_sharing/src/widgets/get_bytes_from_asset.dart';
import 'package:ride_sharing/src/widgets/rider_details_bottom_sheet.dart';
import 'package:http/http.dart' as http;

class SearchRiderViewModel extends BaseModel {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final ApiService _apiService = ApiService();
  final CameraPosition initialLocation = const CameraPosition(
    target: LatLng(26.8876621, 80.995846),
    zoom: 15.0,
  );
  GoogleMapController? mapController;
  late Position currentPosition;
  String currentAddress = "";

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String startAddress = '';
  String destinationAddress = '';

  Set<Marker> markers = {};

  final db = FirebaseFirestore.instance;
  List<Rider> nearbyRiders = [];

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  init(args) async {
    getCurrentLocation();
    print("==========================================");
    print(startAddressController.text);
    print(destinationAddressController.text);
    print(args);
    print("==========================================");
    startAddressController.text = args?["startAddress"] ?? '';
    destinationAddressController.text = args?["destinationAddress"] ?? '';

    List<Location> l = await locationFromAddress(startAddressController.text);
    print(l);
    mapController
        ?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(l[0].latitude, l[0].longitude), zoom: 15.0),
          ),
        )
        .then((d) => notifyListeners());
    notifyListeners();
  }

  getNewPosition(String value) async {
    List<Location> l = await locationFromAddress(value);
    print(l[0]);
    // print("==========================================================");
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(l[0].latitude, l[0].longitude), zoom: 13.0),
      ),
    );
    notifyListeners();
  }

  getAddress() async {
    try {
      // Places are retrieved using the coordinates
      List<Placemark> p = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      // Taking the most probable result
      Placemark place = p[0];

      currentAddress =
          "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      print("========================");
      print(currentAddress);
      print("========================");
      // Update the text of the TextField
      // startAddressController.text = currentAddress;

      // Setting the user's present location as the starting address
      startAddress = currentAddress;
    } catch (e) {
      print(e);
    }
  }

  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentPosition = position;
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target:
                  LatLng(currentPosition.latitude, currentPosition.longitude),
              zoom: 15.0),
        ),
      );
      await getAddress();
    }).catchError((e) {
      print("////////////");
      print(e);
    });
  }

  void getNearbyRiders(BuildContext context) async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/icons/person.png', 150);
    List<Rider> riders =
        (await db.collection('availableRiders').get()).docs.map((e) {
      var data = e.data();
      return Rider(
          id: e.id,
          name: data["name"],
          source: data["source"],
          destination: data["destination"]);
    }).toList();

    nearbyRiders = riders.where((r) {
      var dist = Geolocator.distanceBetween(currentPosition.latitude,
          currentPosition.longitude, r.source.latitude, r.source.longitude);
      // print(dist);
      return dist < 10000;
    }).toList();

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 13.0),
      ),
    );

    markers.clear();
    for (Rider r in nearbyRiders) {
      markers.add(
        Marker(
          onTap: () {
            String buttonText = "Accept Ride";
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) =>
                  RiderDetailsBottomSheet(rider: r, func: () => acceptRide(r)),
              enableDrag: true,
            );
          },
          markerId: MarkerId(r.id),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          position: LatLng(r.source.latitude, r.source.longitude),
          infoWindow: InfoWindow(
            title: r.name,
            snippet: r.name,
          ),
        ),
      );
    }
    notifyListeners();
    print(nearbyRiders);
  }

  Future<bool> calculateDistance() async {
    try {
      List<Location> startPlacemark =
          await locationFromAddress(startAddressController.text);
      List<Location> destinationPlacemark =
          await locationFromAddress(destinationAddressController.text);

      double startLatitude = startAddressController.text == currentAddress
          ? currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = startAddressController.text == currentAddress
          ? currentPosition.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startString = "($startLongitude, $startLongitude)";
      String destinationString =
          "($destinationLatitude, $destinationLongitude)";

      Marker startMarker = Marker(
        markerId: MarkerId(startString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow:
            InfoWindow(title: 'Start $startString', snippet: startAddress),
      );

      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
            title: 'Destination $destinationString',
            snippet: destinationAddress),
      );

      markers.clear();
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      double miny = min(startLatitude, destinationLatitude);
      double maxy = max(startLatitude, destinationLatitude);
      double minx = min(startLongitude, destinationLongitude);
      double maxx = max(startLongitude, destinationLongitude);

      mapController?.animateCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(miny, minx), northeast: LatLng(maxy, maxx)),
          100.0));

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);
      notifyListeners();

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  _createPolylines(startLat, startLon, destLat, destLon) async {
    polylinePoints = PolylinePoints();
    var MAPAPIKEY = FlutterConfig?.get('MAPS_API_HTTPS') ?? "";
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      MAPAPIKEY,
      PointLatLng(startLat, startLon),
      PointLatLng(destLat, destLon),
      travelMode: TravelMode.driving,
      optimizeWaypoints: true,
    );
    print("ERRORS ================================");
    print(result.points);
    print(result.errorMessage);

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        print(point.latitude.toString() + " " + point.longitude.toString());
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    polylines.clear();
    PolylineId id = PolylineId(startAddress + destinationAddress);
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
    // notifyListeners();
  }

  void acceptRide(Rider r) async {
    print("yoooooooooooooooooooo");
    var token =
        "cuiqIW3wT2ycOyijjoOdJK:APA91bFbPRFj6wRNowB7jo7xAuVE_KGvnZy-wIPQPkT936djHz1GT_Bxss_B2bH427EAz4aIp8mPiInV0fINchIlHPhZHjm3KeAGqBQtc8knkfTirHwTGqkzN6NCiYuqepWgROstaB3M";
    final ApiResponse response =
        await _apiService.sendFirebaseNotification(token);
    print(response.data);
    // final uri = Uri.parse("http://192.168.1.11:3000/firebase/send");
    // final response = await http.post(uri, body: {"tokens": token});

    // print(response.body);
  }
}
