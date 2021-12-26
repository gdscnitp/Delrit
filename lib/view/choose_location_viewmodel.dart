import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/provider/base_model.dart';

class ChooseLocationViewModel extends BaseModel {
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

  getAddress({LatLng? latlng}) async {
    try {
      List<Placemark> p;
      // Places are retrieved using the coordinates
      if (latlng == null) {
        p = await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude);
      } else {
        p = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
      }

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
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void getNewPosition(String value) async {
    List<Location> l = await locationFromAddress(value);
    print(l[0]);
    // print("==========================================================");
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(l[0].latitude, l[0].longitude), zoom: 13.0),
      ),
    );
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId("current_location"),
        position: LatLng(l[0].latitude, l[0].longitude),
        infoWindow: InfoWindow(title: "Your Location"),
        draggable: true,
        onDragEnd: (value) async {
          await getAddress(latlng: value);
          notifyListeners();
        },
      ),
    );
    notifyListeners();
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

      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId("current_location"),
          position: LatLng(currentPosition.latitude, currentPosition.longitude),
          infoWindow: InfoWindow(title: "Your Location"),
          draggable: true,
          onDragEnd: (value) async {
            await getAddress(latlng: value);
            notifyListeners();
          },
        ),
      );

      notifyListeners();
      await getAddress();
    }).catchError((e) {
      print("////////////");
      print(e);
    });
  }
}
