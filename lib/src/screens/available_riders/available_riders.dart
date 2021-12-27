import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/constant/text_style.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/available_riders_viewmodel.dart';
import 'components/body.dart';

class AvailableRiders extends StatelessWidget {
  const AvailableRiders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Taking devices exact height and widths
    SizeConfig().init(context);
    return BaseView<AvailableRidersViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Available Riders',
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
        ),
      );
    });
  }
}
