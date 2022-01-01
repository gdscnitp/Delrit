import 'package:flutter/material.dart';

Widget rideConfirmed(
    {required String drivername, required BuildContext context}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'You confirmed ride share with $drivername',
          maxLines: 2,
          //style: ksecTextStyle,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'Happy Journey!',
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Color(0xFF2eb574),
              ),
        ),
      ],
    ),
  );
}
