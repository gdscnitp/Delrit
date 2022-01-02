import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing/config/app_config.dart' as config;
import 'package:ride_sharing/src/models/riders.dart';
import 'package:ride_sharing/src/models/user.dart';
import 'package:ride_sharing/src/screens/rider_details/rider_details.dart';
import 'package:ride_sharing/src/utils/dateutils.dart';

class RiderDetailsCard extends StatefulWidget {
  final RiderModel rider;
  final String? driveId;
  const RiderDetailsCard({Key? key, required this.rider, required this.driveId})
      : super(key: key);

  @override
  _RiderDetailsCardState createState() => _RiderDetailsCardState();
}

class _RiderDetailsCardState extends State<RiderDetailsCard> {
  //---------VARIABLES-------//
  String? source, destination, time;
  UserProfileModel? riderInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSourceAndDestination();
    getTime();
    getRiderInfo();
  }

  getTime() {
    ///Pass the timestamp and use it
    final ridetime = DateTime.fromMillisecondsSinceEpoch(widget.rider.time);

    setState(() {
      time = DateFormat.yMMMd().add_jm().format(ridetime);
    });

    ///yMMMEd for day name in short i.e Mon
  }

  void getSourceAndDestination() async {
    Placemark place;
    place = (await placemarkFromCoordinates(
        widget.rider.source.latitude, widget.rider.source.longitude))[0];
    setState(() {
      widget.rider.setSourceName =
          "${place.name}, ${place.locality}, ${place.postalCode}";
      source = "${place.name}, ${place.locality}, ${place.postalCode}";
    });
    place = (await placemarkFromCoordinates(widget.rider.destination.latitude,
        widget.rider.destination.longitude))[0];
    setState(() {
      widget.rider.setDestinationName =
          "${place.name}, ${place.locality}, ${place.postalCode}";
      destination = "${place.name}, ${place.locality}, ${place.postalCode}";
    });
  }

  void getRiderInfo() async {
    final db = FirebaseFirestore.instance;
    // print(widget.rider.uid);
    // print("======================");
    var data =
        (await db.collection('users').doc(widget.rider.uid).get()).data();
    print(data);
    setState(() {
      riderInfo = userProfileFromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Container(
        height: height / 3.2,
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
                    const SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          riderInfo?.name ?? "",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: config.getProportionateScreenHeight(10),
                        ),
                        Text(
                          '3.5 Stars',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: config.getProportionateScreenHeight(20),
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
                      "On ${timestampToHumanReadable(widget.rider.time)}",
                      //'On 8th Dec,2021 at 8:30 A.M.'
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
                        '/rider-details',
                        arguments: {
                          'rider': widget.rider,
                          'riderInfo': riderInfo,
                          'driveId': widget.driveId,
                        },
                      );
                      //type 'Null' is not a subtype of type 'RiderModel' in type cast
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
