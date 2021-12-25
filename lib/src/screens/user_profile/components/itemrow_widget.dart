import 'package:flutter/material.dart';

const TextStyle kTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 19,
);

Widget itemRow({required String parameter, required String? value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(
        flex: 1,
        child: Text(
          parameter,
          style: kTextStyle,
        ),
      ),
      Flexible(
        flex: 2,
        child: Text(
          value as String,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: kTextStyle,
        ),
      ),
    ],
  );
}
