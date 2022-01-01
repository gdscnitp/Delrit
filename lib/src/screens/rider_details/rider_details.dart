import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/models/riders.dart';
import 'package:ride_sharing/view/rider_details_viewmodel.dart';
import 'components/body.dart';

class RiderDetails extends StatelessWidget {
  final Map<String, dynamic>? riderDetails;
  const RiderDetails({Key? key, this.riderDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<RiderDetailsViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Rider Details',
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
          rider: riderDetails,
        ),
      );
    });
  }
}
