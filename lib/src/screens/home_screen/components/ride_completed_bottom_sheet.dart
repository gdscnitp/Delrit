import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/screens/driver_details/components/reusable_button.dart';
import 'package:ride_sharing/view/home_screen_view_model.dart';

Widget starsRowWidget(
    {required HomeScreenViewModel model, required String uid}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Flexible(
        flex: 1,
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Image.asset(
              'assets/images/user_img.png',
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
          ),
        ),
      ),
      Flexible(
        flex: 2,
        child: RatingBar.builder(
          initialRating: 4,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.blue,
          ),
          onRatingUpdate: (rating) {
            print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
            model.users[uid] = rating.toInt();
            print(model.users);
            print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
          },
          updateOnDrag: true,
        ),
      ),
    ],
  );
}

Widget rideCompleted(BuildContext context, HomeScreenViewModel model) {
  return Padding(
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
                    color: Color(0xFF2eb574),
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
        Divider(),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        Text(
          'Driver',
          style: Theme.of(context).textTheme.bodyText2,
        ),

        ///For 1 Driver uid
        starsRowWidget(model: model, uid: model.trip.driver.driverUid),
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
            itemCount: model.trip.riders.length,
            itemBuilder: (context, index) {
              return starsRowWidget(
                  model: model, uid: model.trip.riders[index].riderUid);
            }),
        SizedBox(
          height: getProportionateScreenHeight(25),
        ),
        resuableButton(
          text: 'Submit',
          onPress: () {
            ///Submit all the ratings show progress and the pop the context
            model.users.forEach((key, value) {
              model.rateUsers(uid: key, starCount: value);
            });
            Navigator.of(context).pop();
          },
          buttoncolor: Colors.blue,
        ),
      ],
    ),
  );
}
