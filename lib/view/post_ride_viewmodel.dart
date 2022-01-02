import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing/enum/view_state.dart';
import 'package:ride_sharing/provider/base_model.dart';

class PostRideViewModel extends BaseModel {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  late Position currentPosition;
  GoogleMapController? mapController;
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  String currentAddress = "";
  String startAddress = '';
  String destinationAddress = '';
  final db = FirebaseFirestore.instance;

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  DateTime selectedDate = DateTime(0);

  final List<String> vehicles = ['Choose vehicle', 'Car', 'Bike'];
  String selectedVehicle = 'Choose vehicle';

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

  String getText() {
    if (selectedDate.year == 0) {
      return 'Pick Ride Time';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(selectedDate);
    }
  }

  // Future<void> selectDateTime(BuildContext context) async {
  //   final DateTime? picked = await DatePicker.showDateTimePicker(
  //     context,
  //     showTitleActions: true,
  //     maxTime: DateTime(DateTime.now().year + 5),
  //     minTime: DateTime.now(),
  //     theme: DatePickerTheme(
  //       headerColor: Colors.orange,
  //       backgroundColor: Colors.grey.shade300,
  //       itemStyle: const TextStyle(
  //         color: Colors.black,
  //         fontWeight: FontWeight.bold,
  //         fontSize: 18,
  //       ),
  //       doneStyle: const TextStyle(
  //         color: Colors.green,
  //         fontSize: 16,
  //       ),
  //     ),
  //     onChanged: (date) {
  //       print('change $date in timezone ' +
  //           date.timeZoneOffset.inHours.toString());
  //     },
  //     onConfirm: (date) {
  //       print('confirm $date');
  //     },
  //     currentTime: DateTime.now(),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     selectedDate = picked;
  //     notifyListeners();
  //   }
  // }

  void selectDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2022),
    );
    print(date);
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    print(time);

    if (date != null && time != null) {
      selectedDate =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      notifyListeners();
    }
  }

  void clear() {
    startAddressController.clear();
    destinationAddressController.clear();
    selectedDate = DateTime(0);
    notifyListeners();
  }

  Future<String> addRideToDb(BuildContext context) async {
    setState(ViewState.Busy);
    var sourceCord = await locationFromAddress(startAddressController.text);
    var destinationCord =
        await locationFromAddress(destinationAddressController.text);
    String id = (await db.collection("availableRiders").add({
      "uid": FirebaseAuth.instance.currentUser?.uid ?? "",
      "source": GeoPoint(sourceCord[0].latitude, sourceCord[0].longitude),
      "destination":
          GeoPoint(destinationCord[0].latitude, destinationCord[0].longitude),
      "sourceName": startAddressController.text,
      "destinationName": destinationAddressController.text,
      "time": selectedDate.millisecondsSinceEpoch,
    }))
        .id;
    clear();
    setState(ViewState.Idle);
    return id;
  }

  void locationCallBackStarting(String? value) {
    startAddress = value ?? "";
    startAddressController.text = value ?? "";
    notifyListeners();
    if (value != null) {
      getNewPosition(value);
    }
  }

  void locationCallBackDestination(String? value) {
    destinationAddress = value ?? "";
    destinationAddressController.text = value ?? "";
    notifyListeners();
  }
}
