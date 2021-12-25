import 'package:flutter/material.dart';

const TextStyle kTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 19,
);

Widget starsColumnWidget({required int starscount, required String type}) {
  return Column(
    children: [
      Text(
        type,
        style: kTextStyle,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (var i = 0; i < starscount; i++)
            const IconTheme(
              data: IconThemeData(color: Colors.blue),
              child: Icon(
                Icons.star,
                size: 35,
              ), // I want to iterate this "star icon" for reviews.ratings.length times
            ),
        ],
      ),
    ],
  );
}
