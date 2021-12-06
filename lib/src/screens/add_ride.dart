import 'package:flutter/material.dart';
import 'package:ride_sharing/constant/text_field_style.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/models/map_models.dart';
import 'package:ride_sharing/src/widgets/place_search_text_field.dart';
import 'package:ride_sharing/view/add_ride_viewmodel.dart';

class AddRide extends StatefulWidget {
  const AddRide({Key? key}) : super(key: key);

  @override
  _AddRideState createState() => _AddRideState();
}

class _AddRideState extends State<AddRide> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BaseView<AddRideViewModel>(
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Add Ride'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.05),
              SizedBox(
                width: width * 0.8,
                child: TextField(
                    controller: model.nameController,
                    decoration: kTextFieldStyle(
                        prefixIcon: const Icon(Icons.person),
                        label: "Name",
                        hint: "Enter Name")),
              ),
              SizedBox(height: height * 0.05),
              placeSearchTextField(
                controller: model.sourceController,
                label: "Source",
                hint: "Enter Source",
                width: width,
                prefixIcon: const Icon(Icons.location_on),
                context: context,
                locationCallback: (Suggestion? value) {
                  print("value ${value!.description}");
                },
              ),
              SizedBox(height: height * 0.05),
              placeSearchTextField(
                controller: model.destinationController,
                label: "Destination",
                hint: "Enter Destination",
                width: width,
                prefixIcon: const Icon(Icons.location_on),
                context: context,
                locationCallback: (Suggestion? value) {
                  print("value: ${value!.description}");
                },
              ),
              SizedBox(height: height * 0.05),
              TextButton(
                onPressed: () {
                  model.addRideToDb(context);
                },
                child: const Text("Submit"),
              )
            ],
          )),
    );
  }
}
