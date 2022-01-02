import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/models/riders.dart';
import 'package:ride_sharing/src/models/user.dart';
import 'package:ride_sharing/src/screens/rider_details/components/reusable_button.dart';

class RiderDetailsBottomSheet extends StatefulWidget {
  final Rider rider;
  final UserProfileModel riderInfo;
  final Function func;
  const RiderDetailsBottomSheet(
      {Key? key,
      required this.rider,
      required this.riderInfo,
      required this.func})
      : super(key: key);
  @override
  _RiderDetailsBottomSheetState createState() =>
      _RiderDetailsBottomSheetState();
}

class _RiderDetailsBottomSheetState extends State<RiderDetailsBottomSheet> {
  String buttonText = "Accept Ride";
  final double sizedHeight = getProportionateScreenHeight(7);
  String? source, destination;

  void getSourceAndDestination() async {
    Placemark place;
    place = (await placemarkFromCoordinates(
        widget.rider.source.latitude, widget.rider.source.longitude))[0];
    setState(() {
      source = "${place.name}, ${place.locality}, ${place.postalCode}";
    });
    place = (await placemarkFromCoordinates(widget.rider.destination.latitude,
        widget.rider.destination.longitude))[0];
    setState(() {
      destination = "${place.name}, ${place.locality}, ${place.postalCode}";
    });
  }

  @override
  void initState() {
    super.initState();
    getSourceAndDestination();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(450),
      child: Column(
        children: [
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          widget.riderInfo.name ?? "",
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
                              child:
                                  Image.asset('assets/images/check_mark.png'),
                            ),
                            Text(
                              'Vaccinated',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    color: Color(0xFF2eb574),
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sizedHeight,
                        ),
                        Text(
                          'Gender : ${widget.riderInfo.gender ?? ""}',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: sizedHeight,
                        ),
                        Text(
                          'Age : ${widget.riderInfo.age ?? ""}',
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
                        'Source : $source',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Text(
                        'Destination : $destination',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Text(
                        'On 8th Dec,2021 at 8:30 A.M.',
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
                            '+91 60708090100',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: resuableButton(
                              text: 'Chat',
                              onPress: () => widget.func(),
                              buttoncolor: null,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: resuableButton(
                              text: 'Call',
                              buttoncolor: null,
                              onPress: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
