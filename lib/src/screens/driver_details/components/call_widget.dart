import 'package:flutter/material.dart';
import 'package:ride_sharing/view/driver_details_viewmodel.dart';
import 'reusable_button.dart';

Widget rideNotConfirmed(
    {required BuildContext context,
    required String drivername,
    required DriverDetailsViewModel model}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$drivername has requested.',
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            resuableButton(
                text: 'Deny',
                buttoncolor: Color(0xFFf46647),
                onPress: () {
                  model.rideStatus(false);
                }),
            resuableButton(
                text: 'Accept',
                buttoncolor: Color(0xFF65cb14),
                onPress: () {
                  model.rideStatus(true);
                }),
          ],
        ),
      ],
    ),
  );
}
