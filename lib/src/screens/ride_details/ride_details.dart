import 'package:flutter/material.dart';
import 'package:ride_sharing/src/models/trips.dart';
import 'components/body.dart';
import 'package:ride_sharing/src/widgets/app_bar.dart';

class RideDetails extends StatelessWidget {
  final TripsModel trip;
  const RideDetails(this.trip, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle? commonTextStyle = Theme.of(context).textTheme.headline2;
    return Body(context, trip, commonTextStyle!);
  }
}
