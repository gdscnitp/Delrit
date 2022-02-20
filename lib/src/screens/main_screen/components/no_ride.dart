import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/widgets/dragging_handle.dart';

class NoRideBS extends StatefulWidget {
  const NoRideBS({Key? key}) : super(key: key);

  @override
  _NoRideBSState createState() => _NoRideBSState();
}

class _NoRideBSState extends State<NoRideBS> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(750),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 12),
          const CustomDraggingHandle(),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/delrit_1.png',
            height: 100,
            width: 180,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed("/searchrider");
              },
              icon: const Icon(Icons.add),
              label: const Text('Post a Ride'),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed("/post-ride");
              },
              icon: const Icon(Icons.search),
              label: const Text('Get a ride'),
            ),
          ),
        ],
      ),
    );
  }
}
