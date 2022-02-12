import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/enum/view_state.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/screens/main_screen/components/no_ride.dart';
import 'package:ride_sharing/src/screens/main_screen/components/ride_confirmed.dart';
import 'package:ride_sharing/view/live_tracking_viewmodel.dart';
import 'package:ride_sharing/view/main_screen_viewmodel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    return BaseView<MainScreenViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        switch (model.rideState) {
          case RideState.NO_RIDE:
            bottomSheet = const NoRideBS();
            break;
          case RideState.RIDE_CONFIRMED:
            bottomSheet = RideConfirmedBS(model);
            break;
          default:
        }
        return Scaffold(
          key: model.scaffoldkey,
          backgroundColor: Colors.yellow[50],
          body: Stack(
            children: [
              GoogleMap(
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
              DraggableScrollableSheet(
                initialChildSize: 0.35,
                minChildSize: 0.35,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Card(
                      elevation: 12.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      margin: const EdgeInsets.all(0),
                      child: bottomSheet,
                    ),
                  );
                },
              ),
            ],
          ),
          // body: GoogleMap(
          //   myLocationEnabled: true,
          //   compassEnabled: true,
          //   tiltGesturesEnabled: false,
          //   markers: Set<Marker>.of(model.markers),
          //   polylines: Set<Polyline>.of(model.polylines.values),
          //   initialCameraPosition: model.initialLocation,
          //   onMapCreated: (GoogleMapController controller) {
          //     model.mapController = controller;
          //     model.getCurrentLocation();
          //   },
          // ),
          // bottomSheet: model.state == ViewState.Busy
          //     ? const Center(child: CircularProgressIndicator())
          //     : bottomSheet,
        );
      },
    );
  }
}
