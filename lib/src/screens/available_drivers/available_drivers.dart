import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/available_drivers_viewmodel.dart';
import 'components/body.dart';
import 'package:flutter/material.dart';

class AvailableDrivers extends StatelessWidget {
  final String? rideId;
  const AvailableDrivers({Key? key, this.rideId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AvailableDriversViewModel>(
        onModelReady: (model) => model.init(rideId!),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                'Available Drivers',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
            ),
            body: Body(model),
          );
        });
  }
}
