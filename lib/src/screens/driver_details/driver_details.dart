import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/driver_details_viewmodel.dart';
import 'components/body.dart';

class DriverDetails extends StatelessWidget {
  final Map<String, dynamic>? driverDetails;
  const DriverDetails({Key? key, this.driverDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DriverDetailsViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Driver Details',
            style: Theme.of(context).textTheme.headline2,
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_outlined,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Body(
          model: model,
          driver: driverDetails,
        ),
      );
    });
  }
}
