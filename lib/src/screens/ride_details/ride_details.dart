import 'package:flutter/material.dart';
import 'components/body.dart';
import 'package:ride_sharing/src/widgets/app_bar.dart';

class RideDetails extends StatelessWidget {
  const RideDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle? commonTextStyle = Theme.of(context).textTheme.headline2;
    return Scaffold(
      appBar: appBar('Ride Details', context),
      body: Body(context, commonTextStyle!),
    );
  }
}
