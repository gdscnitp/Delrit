import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ride_sharing/enum/view_state.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/services/prefs_services.dart';
import 'package:ride_sharing/src/models/drivers.dart';
import 'package:ride_sharing/src/models/riders.dart';
import 'package:ride_sharing/src/models/trips.dart';
import 'package:ride_sharing/src/models/user.dart';
import 'package:ride_sharing/src/screens/main_screen/components/no_ride.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreenViewModel extends BaseModel {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final Prefs prefs = Prefs();
  final CameraPosition initialLocation = const CameraPosition(
    target: LatLng(26.8876621, 80.995846),
    zoom: 10.0,
  );
  late GoogleMapController mapController;
  String currentAddress = "";
  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;

  late LocationData currentPosition;
  late LatLng sourceLocation;
  late LatLng destinationLocation;
  late Location location;

  String? uid = FirebaseAuth.instance.currentUser?.uid;

  late TripsModel tripData;

  void init() async {
    setState(ViewState.Busy);
    location = Location();
    // location.onLocationChanged.listen((LocationData locationData) {
    //   print(
    //       locationData.latitude.toString() + locationData.longitude.toString());
    //   currentPosition = locationData;
    //   updatePin();
    // });
    setSourceAndDestinationIcons();

    if (uid == null) return;

    String tripId = await prefs.getMyTripId();
    print("===================================================");
    print(tripId);
    print("===================================================");

    if (tripId == "") {
      setRideState(RideState.NO_RIDE);
      return;
    }

    var data = (await db.collection("trips").doc(tripId).get()).data();
    tripData = TripsModel.fromJson(data!);

    if (tripData.driver.driverUid == uid) {
      if (tripData.driver.status == "confirmed") {
        setRideState(RideState.RIDE_CONFIRMED);
      }
    }

    getAllTripData();
    setState(ViewState.Idle);
    notifyListeners();
  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
            'assets/images/driving_marker.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
            'assets/images/destination_marker.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }

  void updatePin() async {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(currentPosition.latitude!, currentPosition.longitude!),
      ),
    ));
    markers.removeWhere((m) => m.markerId.value == 'Source');
    markers.add(
      Marker(
        markerId: const MarkerId("Source"),
        position: LatLng(currentPosition.latitude!, currentPosition.longitude!),
        infoWindow: const InfoWindow(title: "Your Location"),
        icon: sourceIcon!,
      ),
    );
    notifyListeners();
  }

  void getCurrentTripMap() async {
    await location.getLocation().then((LocationData position) async {
      currentPosition = position;
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target:
                  LatLng(currentPosition.latitude!, currentPosition.longitude!),
              zoom: 10.0),
        ),
      );

      if (rideState != RideState.NO_RIDE) {
        sourceLocation = LatLng(tripData.driver.driveData!.source.latitude,
            tripData.driver.driveData!.source.longitude);

        destinationLocation = LatLng(
            tripData.driver.driveData!.destination.latitude,
            tripData.driver.driveData!.destination.longitude);

        markers.clear();
        markers.add(
          Marker(
            markerId: const MarkerId("Source"),
            position: sourceLocation,
            infoWindow: const InfoWindow(title: "Source Location"),
            icon: sourceIcon!,
          ),
        );

        markers.add(
          Marker(
            markerId: const MarkerId("Destination"),
            position: destinationLocation,
            infoWindow: const InfoWindow(title: "Destination Location"),
            icon: destinationIcon!,
          ),
        );

        createPolylines(
          sourceLocation.latitude,
          sourceLocation.longitude,
          destinationLocation.latitude,
          destinationLocation.longitude,
        );
      }

      notifyListeners();
      // await getAddress();
    }).catchError((e) {
      print("////////////");
      print(e);
    });
  }

  void createPolylines(startLat, startLon, destLat, destLon) async {
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
    PolylineId id = PolylineId("change");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    notifyListeners();
  }

  getAllTripData() async {
    var data;
    data = (await db.collection("users").doc(tripData.driver.driverUid).get())
        .data();

    tripData.driver.setDriverProfile = UserProfileModel.fromJson(data!);

    data = (await db
        .collection("availableDrivers")
        .doc(tripData.driver.driveId)
        .get());
    tripData.driver.setDriveData = DriverModel.fromJson(data.data(), data.id);
    notifyListeners();

    for (Rider rider in tripData.riders) {
      data = (await db.collection("users").doc(rider.riderUid).get()).data();
      rider.setRiderProfile = UserProfileModel.fromJson(data!);
      print("ok");
      print(rider.riderProfile?.name);

      data = (await db.collection("availableRiders").doc(rider.rideId).get());
      rider.setRideData = RiderModel.fromJson(data.data(), data.id);
      notifyListeners();
    }
  }
}
