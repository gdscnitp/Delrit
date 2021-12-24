import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/models/map_models.dart';
import 'package:ride_sharing/src/widgets/place_search_text_field.dart';
import 'package:ride_sharing/view/choose_location_viewmodel.dart';
import 'package:ride_sharing/view/complete_profile_viewmodel.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BaseView<ChooseLocationViewModel>(
      onModelReady: (model) => model.getCurrentLocation(),
      builder: (context, model, child) => Scaffold(
        key: model.scaffoldkey,
        body: Stack(
          children: [
            GoogleMap(
              markers: Set<Marker>.of(model.markers),
              initialCameraPosition: model.initialLocation,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                model.mapController = controller;
              },
            ),
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
                            'Choose Location',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const SizedBox(height: 10),
                          placeSearchTextField(
                            context: context,
                            label: 'Enter Location',
                            hint: 'Choose location',
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
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, model.startAddress);
                            },
                            // color: Colors.red,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(20.0),
                            // ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Done",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                              "Hold and Drag Marger to set new location"),
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
