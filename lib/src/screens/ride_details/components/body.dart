import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'driver_card.dart';
import 'travallers_card.dart';
import 'input_fields.dart';

Widget Body(BuildContext context, TextStyle commonTextStyle) {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(15),
          horizontal: getProportionateScreenWidth(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'My Start Location',
          style: commonTextStyle,
        ),
        inputFormField(commonTextStyle as TextStyle, 'Raja Bazar,Patna'),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        Text(
          'My Destination',
          style: commonTextStyle,
        ),
        inputFormField(commonTextStyle, 'NIT Patna'),
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
        driverDetailsCard(context, commonTextStyle),
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
        travallerDetailsCard(commonTextStyle),
        SizedBox(
          height: getProportionateScreenHeight(12),
        ),
        travallerDetailsCard(commonTextStyle),
        SizedBox(
          height: getProportionateScreenHeight(12),
        ),
      ]),
    ),
  );
}
