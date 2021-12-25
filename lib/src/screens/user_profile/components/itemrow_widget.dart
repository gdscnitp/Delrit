import 'package:flutter/material.dart';

Widget itemRow(
    {required String parameter,
    required String? value,
    required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(
        flex: 1,
        child: Text(
          parameter,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      Flexible(
        flex: 2,
        child: Text(
          value as String,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    ],
  );
}
