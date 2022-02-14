import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/provider/base_model.dart';

class CompleteProfileViewModel extends BaseModel {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

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

  String gender = "Select gender";

  void setGender(String val) {
    gender = val;
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
      startAddressController.text = currentAddress;

      // Setting the user's present location as the starting address
      startAddress = currentAddress;
      notifyListeners();
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

      markers.clear();
      markers.add(Marker(
        markerId: MarkerId("current_location"),
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
        infoWindow: InfoWindow(title: "Your Location"),
        draggable: true,
        onDrag: (value) {
          print("yooooooo");
          // currentPosition = value;
          // getAddress();
        },
        // onDragEnd: (value) => getAddress(),
      ));

      notifyListeners();
      await getAddress();
    }).catchError((e) {
      print("////////////");
      print(e);
    });
  }

  void clear() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    ageController.clear();
    notifyListeners();
  }

  void updateLocation(String result) {
    addressController.text = result;
    notifyListeners();
  }

  void save(BuildContext context) {
    print(nameController.text);
    print(phoneController.text);
    print(emailController.text);
    print(gender);
    print(ageController.text);
    print(addressController.text);
    print(auth.currentUser?.uid);

    String? uid = auth.currentUser?.uid;

    if (uid != null) {
      db.collection("users").doc(uid).update({
        "name": nameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "address": addressController.text,
        "age": ageController.text,
        "gender": gender,
      }).then((value) {
        print("User saved to db");
        navigationService.navigateTo("/access-permission",
            withreplacement: true);
      });
    }

    // notifyListeners();
  }
}
