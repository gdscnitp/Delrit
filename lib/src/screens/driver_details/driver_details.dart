import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/driver_details_viewmodel.dart';
import 'components/body.dart';

class DriverDetails extends StatelessWidget {
  final Map<String, dynamic>? args;
  const DriverDetails({Key? key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DriverDetailsViewModel>(
        onModelReady: (model) => model.init(args),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Driver Details',
                style: Theme.of(context).textTheme.headline2,
              ),
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            body: Body(
              model: model,
            ),
          );
        });
  }
}
