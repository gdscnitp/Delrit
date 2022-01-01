import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/models/map_models.dart';
import 'package:ride_sharing/src/widgets/place_search_text_field.dart';
import 'package:ride_sharing/view/search_rider_viewmodel.dart';

class NearbyRiders extends StatefulWidget {
  final Map<String, dynamic> args;
  const NearbyRiders({Key? key, required this.args}) : super(key: key);

  @override
  _NearbyRidersState createState() => _NearbyRidersState();
}

class _NearbyRidersState extends State<NearbyRiders> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BaseView<SearchRiderViewModel>(
      onModelReady: (model) => model.init(widget.args),
      builder: (context, model, child) => Scaffold(
        key: model.scaffoldkey,
        body: Stack(
          children: [
            GoogleMap(
              markers: Set<Marker>.of(model.markers),
              polylines: Set<Polyline>.of(model.polylines.values),
              initialCameraPosition: model.initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                model.mapController = controller;
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
                                  model.startAddressController.text =
                                      model.currentAddress;
                                  model.startAddress = model.currentAddress;
                                },
                              ),
                              controller: model.startAddressController,
                              focusNode: model.startAddressFocusNode,
                              width: width,
                              locationCallback: (Suggestion? value) {
                                setState(() {
                                  model.startAddress = value!.description;
                                });
                                if (value != null) {
                                  model.getNewPosition(value.description);
                                }
                              }),
                          const SizedBox(height: 10),
                          placeSearchTextField(
                            context: context,
                            label: 'Destination',
                            hint: 'Choose destination',
                            prefixIcon: const Icon(Icons.looks_two),
                            controller: model.destinationAddressController,
                            focusNode: model.desrinationAddressFocusNode,
                            width: width,
                            locationCallback: (Suggestion? value) {
                              setState(() {
                                model.destinationAddress = value!.description;
                                model.destinationAddressController.text =
                                    value.description;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              model.calculateDistance();
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
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              model.getNearbyRiders(context);
                            },
                            // color: Colors.red,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(20.0),
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Search Riders'.toUpperCase(),
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
            model.getCurrentLocation();
          },
        ),
      ),
    );
  }
}
