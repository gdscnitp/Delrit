import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';

Widget driverDetailsCard(BuildContext context, TextStyle commonTextStyle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Image.asset(
                      'assets/images/user_img.png',
                      fit: BoxFit.contain,
                      width: 70,
                      height: 70,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rider Name',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: Image.asset('assets/images/check_mark.png'),
                        ),
                        Text(
                          'Vaccinated',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Gender : Female',
                      style: commonTextStyle,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Age : 35 years',
                      style: commonTextStyle,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/call_black.png',
                  fit: BoxFit.contain,
                  width: 33,
                  height: 33,
                ),
              ),
              Expanded(
                child: Text(
                  '+91 60708090100',
                  style: commonTextStyle,
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/car.png',
                  fit: BoxFit.contain,
                  width: 50,
                  height: 45,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Car Name',
                      style: commonTextStyle,
                    ),
                    Text(
                      'RMX1851',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Source : Patliputra, Patna',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Destination : Mahendru Ghat, Patna',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'On 8th Dec,2021 at 8:30 A.M.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 17,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
