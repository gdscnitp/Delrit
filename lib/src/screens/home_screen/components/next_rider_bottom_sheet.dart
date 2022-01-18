import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';

Widget nextRiderBottomSheet(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: getProportionateScreenHeight(15),
      ),
      Text(
        'Your Next Ride',
        style: Theme.of(context).textTheme.headline2,
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(10),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6.0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
              vertical: getProportionateScreenHeight(13),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/user_img.png',
                        fit: BoxFit.contain,
                        width: getProportionateScreenWidth(48),
                        height: getProportionateScreenHeight(48),
                      ),
                    ),
                    Text('Ms. Username',
                        style: Theme.of(context).textTheme.headline2),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Range Rover',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      'RMX1851',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                Text(
                  'Ride will start in 1 day',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(80),
                      vertical: getProportionateScreenHeight(10),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'See Details',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
