import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';

Widget starsRowWidget({required int starscount}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var i = 0; i < starscount; i++)
              const IconTheme(
                data: IconThemeData(color: Colors.blue),
                child: Icon(
                  Icons.star,
                  size: 35,
                ), // I want to iterate this "star icon" for reviews.ratings.length times
              ),
          ],
        ),
      ),
    ],
  );
}

Widget rideCompleted(BuildContext context) {
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
        Text(
          'Ride Completed',
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Color(0xFF2eb574),
              ),
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
        starsRowWidget(starscount: 5),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        starsRowWidget(starscount: 4),
      ],
    ),
  );
}
