import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing/config/app_config.dart' as config;
import 'package:ride_sharing/src/models/drivers.dart';
import 'package:ride_sharing/src/models/user.dart';
import 'package:ride_sharing/src/screens/driver_details/driver_details.dart';
import 'package:ride_sharing/src/utils/dateutils.dart';

class DriverDetailsCard extends StatefulWidget {
  final DriverModel driver;
  final String? rideId;
  const DriverDetailsCard(
      {Key? key, required this.driver, required this.rideId})
      : super(key: key);

  @override
  _DriverDetailsCardState createState() => _DriverDetailsCardState();
}

class _DriverDetailsCardState extends State<DriverDetailsCard> {
  //---------VARIABLES-------//
  UserProfileModel? driverInfo;
  String? source, destination, time;

  @override
  void initState() {
    super.initState();
    getSourceAndDestination();
    getTime();
    getDriverInfo();
  }

  getTime() {
    ///Pass the timestamp and use it
    final ridetime = DateTime.fromMillisecondsSinceEpoch(widget.driver.time);

    setState(() {
      time = DateFormat.yMMMd().add_jm().format(ridetime);
    });

    ///yMMMEd for day name in short i.e Mon
  }

  void getSourceAndDestination() async {
    Placemark place;
    place = (await placemarkFromCoordinates(
        widget.driver.source.latitude, widget.driver.source.longitude))[0];
    setState(() {
      widget.driver.setSourceName(
          "${place.name}, ${place.locality}, ${place.postalCode}");
      source = "${place.name}, ${place.locality}, ${place.postalCode}";
    });
    place = (await placemarkFromCoordinates(widget.driver.destination.latitude,
        widget.driver.destination.longitude))[0];
    setState(() {
      widget.driver.setDestinationName(
          "${place.name}, ${place.locality}, ${place.postalCode}");
      destination = "${place.name}, ${place.locality}, ${place.postalCode}";
    });
  }

  void getDriverInfo() async {
    final db = FirebaseFirestore.instance;
    var data =
        (await db.collection('users').doc(widget.driver.uid).get()).data();
    print(data);
    setState(() {
      driverInfo = userProfileFromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Container(
        height: height / 2.5,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/user_img.png',
                      height: config.getProportionateScreenHeight(70),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driverInfo?.name ?? "",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: config.getProportionateScreenHeight(7),
                        ),
                        Text(
                          widget.driver.vehicle,
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
                      'From : $source',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: config.getProportionateScreenHeight(10),
                    ),
                    Text(
                      'To : $destination',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: config.getProportionateScreenHeight(10),
                    ),
                    Text(
                      "On ${timestampToHumanReadable(widget.driver.time)}",
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
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/driver-details",
                        arguments: {
                          'driver': widget.driver,
                          'driverInfo': driverInfo,
                          'rideId': widget.rideId,
                        },
                      );
                    },
                    child: const Text(
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
}
