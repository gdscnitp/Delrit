import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/enum/view_state.dart';
import 'package:ride_sharing/src/screens/main_screen/components/star_row_widget.dart';
import 'package:ride_sharing/src/screens/rider_details/components/reusable_button.dart';
import 'package:ride_sharing/view/main_screen_viewmodel.dart';

class RideEndedBottomSheet extends StatefulWidget {
  final MainScreenViewModel model;
  const RideEndedBottomSheet(this.model, {Key? key}) : super(key: key);

  @override
  _RideEndedBottomSheetState createState() => _RideEndedBottomSheetState();
}

class _RideEndedBottomSheetState extends State<RideEndedBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(820),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: getProportionateScreenHeight(30),
                  width: getProportionateScreenWidth(30),
                  child: Image.asset('assets/images/check_mark.png'),
                ),
                Text(
                  'Ride Completed',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: const Color(0xFF2eb574),
                      ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Text(
              'You have reached your destination',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Text(
              'Rate experience with partners',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            const Divider(),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Text(
              'Driver',
              style: Theme.of(context).textTheme.bodyText2,
            ),

            ///For 1 Driver uid
            starsRowWidget(
              model: widget.model,
              name: widget.model.tripData.driver.driverProfile?.name ?? "",
              uid: widget.model.tripData.driver.driverUid,
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Divider(),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Text(
              'People Travelling Along',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),

            ///For Riders UIDS
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.model.tripData.riders.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: starsRowWidget(
                    model: widget.model,
                    name: widget
                            .model.tripData.riders[index].riderProfile?.name ??
                        "",
                    uid: widget.model.tripData.riders[index].riderUid,
                  ),
                );
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            widget.model.state == ViewState.Busy
                ? const CircularProgressIndicator()
                : resuableButton(
                    text: 'Submit',
                    onPress: () async {
                      ///Submit all the ratings show progress and the pop the context
                      await widget.model.rateUsers();
                      Navigator.of(context).pop();
                    },
                    buttoncolor: Colors.blue,
                  ),
          ],
        ),
      ),
    );
  }
}
