import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/models/trips.dart';
import 'package:ride_sharing/src/widgets/dragging_handle.dart';
import 'driver_card.dart';
import 'travallers_card.dart';
import 'input_fields.dart';

Widget Body(BuildContext context, TripsModel trip, TextStyle commonTextStyle) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(15),
        horizontal: getProportionateScreenWidth(20)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 12),
      const Align(
        alignment: Alignment.center,
        child: CustomDraggingHandle(),
      ),
      const SizedBox(height: 20),
      Align(
        alignment: Alignment.center,
        child: Text(
          "Your Next Ride",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      const SizedBox(height: 5.0),
      const Divider(),
      const SizedBox(height: 5.0),
      Text(
        'Start Location',
        style: commonTextStyle,
      ),
      inputFormField(commonTextStyle as TextStyle,
          trip.driver.driveData?.sourceName ?? ""),
      SizedBox(
        height: getProportionateScreenHeight(15),
      ),
      Text(
        'My Destination',
        style: commonTextStyle,
      ),
      inputFormField(
          commonTextStyle, trip.driver.driveData?.destinationName ?? ""),
      SizedBox(
        height: getProportionateScreenHeight(12),
      ),
      Text(
        'Driver',
        style: commonTextStyle,
      ),
      SizedBox(
        height: getProportionateScreenHeight(12),
      ),
      driverDetailsCard(context, trip.driver, commonTextStyle),
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
          for (var rider in trip.riders)
            travallerDetailsCard(rider, commonTextStyle)
        ],
      )
      // Expanded(
      //   child: ListView.builder(
      //     itemCount: trip.riders.length,
      //     itemBuilder: (context, index) {
      //       return Text("hhh");
      //       // return travallerDetailsCard(trip.riders[index], commonTextStyle);
      //     },
      //   ),
      // ),
      // travallerDetailsCard(commonTextStyle),
      // SizedBox(
      //   height: getProportionateScreenHeight(12),
      // ),
      // travallerDetailsCard(commonTextStyle),
      // SizedBox(
      //   height: getProportionateScreenHeight(12),
      // ),
    ]),
  );
}
