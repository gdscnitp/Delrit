import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/models/trips.dart';
import 'package:ride_sharing/src/widgets/launch_url.dart';

Widget travallerDetailsCard(Rider rider, TextStyle commonTextStyle) {
  Widget chip = Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.yellow,
    ),
    child: const Text(
      "pending",
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    ),
  );

  switch (rider.status) {
    case "confirmed":
      chip = Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.green,
        ),
        child: const Text(
          "Confirmed",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      );
      break;
    case "pending":
      chip = Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.yellow,
        ),
        child: const Text(
          "Pending",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      );
      break;
    case "cancelled":
      chip = Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.red,
        ),
        child: const Text(
          "Cancelled",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      );
      break;
    case "started":
      chip = Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue,
        ),
        child: const Text(
          "Started",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      );
      break;
  }
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
                      rider.riderProfile?.name ?? "",
                      style: commonTextStyle,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: Image.asset('assets/images/check_mark.png'),
                        ),
                        const Text(
                          'Vaccinated',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Gender : ${rider.riderProfile?.gender ?? ""}',
                      style: commonTextStyle,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Age : ${rider.riderProfile?.age ?? ""} years',
                      style: commonTextStyle,
                    ),
                    const SizedBox(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  launchURL("tel:+91${rider.riderProfile?.phone ?? ""}");
                },
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Image.asset(
                      'assets/images/call_black.png',
                      fit: BoxFit.contain,
                      width: 33,
                      height: 33,
                    ),
                  ),
                ),
              ),
              Text(
                '+91 ${rider.riderProfile?.phone ?? ""}',
                style: commonTextStyle,
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              chip,
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
        ],
      ),
    ),
  );
}
