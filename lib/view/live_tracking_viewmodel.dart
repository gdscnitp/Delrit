import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ride_sharing/provider/base_model.dart';

class LiveTrackingViewModel extends BaseModel {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final CameraPosition initialLocation = const CameraPosition(
    target: LatLng(26.8876621, 80.995846),
    zoom: 15.0,
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
  late LocationData destinationLocation;
  late Location location;

  void init() async {
    location = Location();
    location.onLocationChanged.listen((LocationData locationData) {
      print(
          locationData.latitude.toString() + locationData.longitude.toString());
      currentPosition = locationData;
      updatePin();
    });
    setSourceAndDestinationIcons();
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
        zoom: 15.0,
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

  void getCurrentLocation() async {
    await location.getLocation().then((LocationData position) async {
      currentPosition = position;
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target:
                  LatLng(currentPosition.latitude!, currentPosition.longitude!),
              zoom: 15.0),
        ),
      );

      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId("Source"),
          position:
              LatLng(currentPosition.latitude!, currentPosition.longitude!),
          infoWindow: const InfoWindow(title: "Your Location"),
          icon: sourceIcon!,
        ),
      );

      markers.add(
        Marker(
          markerId: const MarkerId("Destination"),
          position: const LatLng(26.555513059659972, 80.51012964258656),
          infoWindow: const InfoWindow(title: "Destination Location"),
          icon: destinationIcon!,
        ),
      );

      createPolylines(currentPosition.latitude, currentPosition.longitude,
          26.555513059659972, 80.51012964258656);

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
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
    notifyListeners();
  }
}
