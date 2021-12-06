import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/src/models/riders.dart';

class SearchRiderViewModel extends BaseModel {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
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
      startAddressController.text = currentAddress;

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
    // final BitmapDescriptor personIcon = await BitmapDescriptor.fromAssetImage(
    //     const ImageConfiguration(
    //         devicePixelRatio: 0.0001, size: Size(0.0001, 0.0001)),
    //     'assets/icons/person.png');
    List<Rider> riders =
        (await db.collection('availableRiders').get()).docs.map((e) {
      var data = e.data();
      return Rider(
          id: e.id,
          name: data["name"],
          source: data["source"],
          destination: data["destination"]);
    }).toList();

    // nearbyRiders = riders.where((r) {
    //   var dist = Geolocator.distanceBetween(currentPosition.latitude,
    //       currentPosition.longitude, r.source.latitude, r.source.longitude);
    //   // print(dist);
    //   return dist > 60000;
    // }).toList();
    nearbyRiders = riders;

    markers.clear();
    for (Rider r in nearbyRiders) {
      markers.add(
        Marker(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const Text("ddd"),
            );
          },
          markerId: MarkerId(r.id),
          // icon: personIcon,
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
}
