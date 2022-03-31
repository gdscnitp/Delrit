import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/src/models/drivers.dart';
import 'package:ride_sharing/src/models/user.dart';
import 'package:ride_sharing/src/utils/dateutils.dart';
import 'package:ride_sharing/src/widgets/launch_url.dart';
import 'package:ride_sharing/view/driver_details_viewmodel.dart';
import 'reusable_button.dart';
import 'ride_confirmed.dart';
import 'call_widget.dart';
import 'package:ride_sharing/config/app_config.dart';

class Body extends StatelessWidget {
  final DriverDetailsViewModel model;
  Body({Key? key, required this.model}) : super(key: key);

  final double sizedHeight = getProportionateScreenHeight(7);

  void showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      builder: (builder) {
        return model.isRideConfirmed
            ? rideConfirmed(
                drivername: model.driverInfo!.name ?? "", context: context)
            : rideNotConfirmed(
                context: context, drivername: 'New user', model: model);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: getProportionateScreenHeight(140), //change to app height
          child: Image.asset(
            'assets/images/map.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(8),
            vertical: getProportionateScreenHeight(40),
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/user_img.png',
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.driverInfo!.name ?? "",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                      Row(
                        children: [
                          Container(
                            height: getProportionateScreenHeight(30),
                            width: getProportionateScreenWidth(30),
                            child: Image.asset('assets/images/check_mark.png'),
                          ),
                          Text(
                            'Vaccinated',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: Color(0xFF2eb574),
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                      Text(
                        'Gender : ${model.driverInfo?.gender}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                      Text(
                        'Age : ${model.driverInfo?.age.toString()} years',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                      Text(
                        '3.5 stars',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                      Text(
                        model.driver?.vehicle ?? "",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: sizedHeight,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10),
                    horizontal: getProportionateScreenWidth(45)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Source : ${model.driver?.sourceName}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      'Destination : ${model.driver?.destinationName}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      "On ${timestampToHumanReadable(model.driver!.time)}",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(17),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/call.png',
                          fit: BoxFit.cover,
                          height: 38,
                        ),
                        Text(
                          '+91 ${model.driverInfo?.phone}',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: resuableButton(
                              text: 'Chat',
                              onPress: () {
                                print(model.driverInfo?.id ?? "dd");
                                var meUid =
                                    FirebaseAuth.instance.currentUser?.uid;
                                if (meUid == null) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "/landing", (route) => false);
                                } else {
                                  Navigator.pushNamed(
                                    context,
                                    '/chats',
                                    arguments: model.driverInfo,
                                  );
                                }
                              },
                              buttoncolor: null),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: resuableButton(
                            text: 'Call',
                            buttoncolor: null,
                            onPress: () {
                              launchURL("tel:+91${model.driverInfo?.phone}");
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Center(
                      child: resuableButton(
                        text: 'Request Ride',
                        onPress: () {
                          model.requestRide();
                        },
                        buttoncolor: null,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
