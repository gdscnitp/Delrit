import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/models/trips.dart';
import 'package:ride_sharing/src/widgets/dragging_handle.dart';
import 'package:ride_sharing/view/main_screen_viewmodel.dart';
import 'driver_card.dart';
import 'travallers_card.dart';
import 'input_fields.dart';

Widget Body(BuildContext context, MainScreenViewModel model,
    TextStyle commonTextStyle) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(15),
        horizontal: getProportionateScreenWidth(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Align(
          alignment: Alignment.center,
          child: CustomDraggingHandle(),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Text(
            model.tripData.driver.status == "confirmed"
                ? "Your Next Ride"
                : "Your Current Trip",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        const SizedBox(height: 5.0),
        const Divider(),
        const SizedBox(height: 5.0),
        if (model.tripData.driver.status == "started")
          Center(
            child: Text(
              "Trip OTP: ${model.tripData.rideOtp}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        // Text(
        //   'Start Location',
        //   style: commonTextStyle,
        // ),
        // inputFormField(commonTextStyle as TextStyle,
        //     trip.driver.driveData?.sourceName ?? ""),
        // SizedBox(
        //   height: getProportionateScreenHeight(15),
        // ),
        // Text(
        //   'My Destination',
        //   style: commonTextStyle,
        // ),
        // inputFormField(
        //     commonTextStyle, trip.driver.driveData?.destinationName ?? ""),
        // SizedBox(
        //   height: getProportionateScreenHeight(12),
        // ),
        // Text(
        //   'Driver',
        //   style: commonTextStyle,
        // ),
        SizedBox(
          height: getProportionateScreenHeight(12),
        ),
        driverDetailsCard(context, model.tripData.driver, commonTextStyle),
        SizedBox(
          height: getProportionateScreenHeight(12),
        ),
        Text(
          'Other people travelling along',
          style: commonTextStyle,
        ),
        SizedBox(
          height: getProportionateScreenHeight(12),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            for (var rider in model.tripData.riders)
              travallerDetailsCard(rider, commonTextStyle)
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(12),
        ),
        if (model.tripData.driver.status == "confirmed")
          Center(
            child: ElevatedButton(
              onPressed: () => model.generateAndSaveOtp(),
              child: const Text("Start You Ride"),
            ),
          ),
        if(model.tripData.driver.status == "started")
          Center(
            child: ElevatedButton(
              onPressed: () => model.endTrip(),
              child: const Text("End Your Ride"),
            ),
          )
      ],
    ),
  );
}
