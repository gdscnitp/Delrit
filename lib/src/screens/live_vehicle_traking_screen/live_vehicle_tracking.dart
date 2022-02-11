import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/live_tracking_viewmodel.dart';

class LiveTrack extends StatefulWidget {
  const LiveTrack({Key? key}) : super(key: key);

  @override
  _LiveTrackState createState() => _LiveTrackState();
}

class _LiveTrackState extends State<LiveTrack> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LiveTrackingViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Live Track'),
          ),
          body: GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            markers: Set<Marker>.of(model.markers),
            polylines: Set<Polyline>.of(model.polylines.values),
            initialCameraPosition: model.initialLocation,
            onMapCreated: (GoogleMapController controller) {
              model.mapController = controller;
              model.getCurrentLocation();
            },
          ),
        );
      },
    );
  }
}
