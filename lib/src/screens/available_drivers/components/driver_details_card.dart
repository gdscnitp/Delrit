import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart' as config;

Widget driverDetailsCard(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  double height = MediaQuery.of(context).size.height;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    child: Container(
      height: height / 3.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6.0,
        child: Padding(
          padding: EdgeInsets.only(
              left: config.getProportionateScreenWidth(40),
              top: config.getProportionateScreenHeight(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/user_img.png',
                    height: config.getProportionateScreenHeight(70),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mr. Thangabali',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: config.getProportionateScreenHeight(7),
                      ),
                      Text(
                        'Tata Indica',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: config.getProportionateScreenHeight(7),
                      ),
                      Text(
                        '3.5 Stars',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: config.getProportionateScreenHeight(10),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From : Patliputra, Patna',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: config.getProportionateScreenHeight(10),
                  ),
                  Text(
                    'To : Mahendru Ghat, Patna',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: config.getProportionateScreenHeight(10),
                  ),
                  Text(
                    'On 8th Dec,2021 at 8:30 A.M.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: config.getProportionateScreenHeight(10),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'See Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: config.getProportionateScreenWidth(90),
                      vertical: config.getProportionateScreenHeight(7),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
