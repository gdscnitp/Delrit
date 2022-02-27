import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/view/post_ride_viewmodel.dart';

class Header extends StatelessWidget {
  final PostRideViewModel model;
  const Header({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: getProportionateScreenHeight(250),
          child: Image.asset(
            'assets/images/bg_map.png',
            fit: BoxFit.cover,
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //       horizontal: App(context).appWidth(10),
        //       vertical: App(context).appHeight(5)),
        //   child: Container(
        //     width: App(context).appWidth(80),
        //     decoration: BoxDecoration(
        //       color: Theme.of(context).scaffoldBackgroundColor,
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //     child: TextFormField(
        //       onTap: () async {},
        //       textAlign: TextAlign.center,
        //       decoration: InputDecoration(
        //         border: InputBorder.none,
        //         contentPadding: const EdgeInsets.symmetric(
        //             vertical: 18.0, horizontal: 10.0),
        //         hintText: 'Search for drivers',
        //         hintStyle: const TextStyle(
        //           fontSize: 15,
        //         ),
        //         prefixIcon: const Icon(
        //           Icons.menu,
        //           size: 35,
        //         ),
        //         suffixIcon: GestureDetector(
        //           onTap: () async {},
        //           child: const Icon(
        //             Icons.gps_fixed,
        //             size: 20,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
