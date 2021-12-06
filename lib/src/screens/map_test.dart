import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/auth/secrets.dart';
import 'package:ride_sharing/src/models/map_models.dart';
import 'package:ride_sharing/src/screens/address_search.dart';
import 'package:ride_sharing/src/widgets/place_search_text_field.dart';
import 'package:uuid/uuid.dart';

class MapTest extends StatefulWidget {
  const MapTest({Key? key}) : super(key: key);

  @override
  _MapTestState createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  final CameraPosition _initialLocation = const CameraPosition(
    target: LatLng(25.620598480738305, 85.17301155639352),
    zoom: 19.0,
  );
  GoogleMapController? _mapController;
  late Position _currentPosition;
  String _currentAddress = "";

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  String? _placeDistance;

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  _getAddress() async {
    try {
      // Places are retrieved using the coordinates
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      // Taking the most probable result
      Placemark place = p[0];

      setState(() {
        // Structuring the address
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        print("========================");
        print(_currentAddress);
        print("========================");
        // Update the text of the TextField
        startAddressController.text = _currentAddress;

        // Setting the user's present location as the starting address
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    _currentPosition.latitude, _currentPosition.longitude),
                zoom: 15.0),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print("////////////");
      print(e);
    });
  }

  Future<bool> _calculateDistance() async {
    try {
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark =
          await locationFromAddress(_destinationAddress);

      double startLatitude = _startAddress == _currentAddress
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = _startAddress == _currentAddress
          ? _currentPosition.longitude
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
            InfoWindow(title: 'Start $startString', snippet: _startAddress),
      );

      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
            title: 'Destination $destinationString',
            snippet: _destinationAddress),
      );

      setState(() {
        markers.add(startMarker);
        markers.add(destinationMarker);
      });

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

      _mapController?.animateCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(miny, minx), northeast: LatLng(maxy, maxx)),
          100.0));

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  _createPolylines(startLat, startLon, destLat, destLon) async {
    polylinePoints = PolylinePoints();
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

    PolylineId id = PolylineId(_startAddress + _destinationAddress);
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: Set<Marker>.of(markers),
            polylines: Set<Polyline>.of(polylines.values),
            initialCameraPosition: _initialLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          // Show zoom buttons
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  width: width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Places',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(height: 10),
                        placeSearchTextField(
                            context: context,
                            label: 'Start',
                            hint: 'Choose starting point',
                            prefixIcon: const Icon(Icons.looks_one),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.my_location),
                              onPressed: () {
                                startAddressController.text = _currentAddress;
                                _startAddress = _currentAddress;
                              },
                            ),
                            controller: startAddressController,
                            focusNode: startAddressFocusNode,
                            width: width,
                            locationCallback: (Suggestion? value) {
                              setState(() {
                                _startAddress = value!.description;
                              });
                            }),
                        const SizedBox(height: 10),
                        placeSearchTextField(
                            context: context,
                            label: 'Destination',
                            hint: 'Choose destination',
                            prefixIcon: const Icon(Icons.looks_two),
                            controller: destinationAddressController,
                            focusNode: desrinationAddressFocusNode,
                            width: width,
                            locationCallback: (Suggestion? value) {
                              setState(() {
                                _destinationAddress = value!.description;
                                destinationAddressController.text =
                                    value.description;
                              });
                            }),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: _placeDistance == null ? false : true,
                          child: Text(
                            'DISTANCE: $_placeDistance km',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () async {
                            if (_startAddress == "" ||
                                _destinationAddress == "") {
                              return;
                            }
                            startAddressFocusNode.unfocus();
                            desrinationAddressFocusNode.unfocus();
                            setState(() {
                              if (markers.isNotEmpty) {
                                markers.clear();
                              }
                              if (polylines.isNotEmpty) {
                                polylines.clear();
                              }
                              _placeDistance = null;
                            });

                            _calculateDistance();
                          },
                          // color: Colors.red,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(20.0),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Show Route'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.my_location),
          onPressed: () {
            _getCurrentLocation();
          }),
    );
  }
}
