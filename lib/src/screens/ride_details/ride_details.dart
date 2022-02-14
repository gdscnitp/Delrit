import 'package:flutter/material.dart';
import 'package:ride_sharing/src/models/trips.dart';
import 'package:ride_sharing/view/main_screen_viewmodel.dart';
import 'components/body.dart';

class RideDetails extends StatefulWidget {
  final MainScreenViewModel model;
  const RideDetails(this.model, {Key? key}) : super(key: key);

  @override
  State<RideDetails> createState() => _RideDetailsState();
}

class _RideDetailsState extends State<RideDetails> {
  @override
  Widget build(BuildContext context) {
    final TextStyle? commonTextStyle = Theme.of(context).textTheme.headline2;
    return Body(
      context,
      widget.model,
      commonTextStyle!,
    );
  }
}
