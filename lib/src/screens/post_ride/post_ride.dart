import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/post_ride_viewmodel.dart';
import 'components/body.dart';

class PostRide extends StatelessWidget {
  const PostRide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PostRideViewModel>(
      onModelReady: (model) => model.getCurrentLocation(),
      builder: (context, model, child) => Scaffold(
        key: model.scaffoldkey,
        body: Body(context, model),
      ),
    );
  }
}
