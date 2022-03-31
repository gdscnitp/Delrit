import 'package:flutter/material.dart';

Future<bool> showExitPopup(BuildContext context) async {
  return await showDialog(
        //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Do you really want to exit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              //return false when click on "NO"
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              //return true when click on "Yes"
              child: const Text('Yes'),
            ),
          ],
        ),
      ) ??
      false; //if showDialouge had returned null, then return false
}
