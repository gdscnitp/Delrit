import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/screens/ride_details/ride_details.dart';
import 'package:ride_sharing/src/widgets/dragging_handle.dart';
import 'package:ride_sharing/view/main_screen_viewmodel.dart';

class RideConfirmedBS extends StatefulWidget {
  final MainScreenViewModel model;
  const RideConfirmedBS(this.model, {Key? key}) : super(key: key);

  @override
  _RideConfirmedBSState createState() => _RideConfirmedBSState();
}

class _RideConfirmedBSState extends State<RideConfirmedBS> {
  @override
  Widget build(BuildContext context) {
    return RideDetails(widget.model.tripData);
  }
}
