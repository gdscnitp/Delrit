import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ride_sharing/view/main_screen_viewmodel.dart';

Widget starsRowWidget(
    {required MainScreenViewModel model,
    required String name,
    required String uid}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Flexible(
        flex: 1,
        child: Column(
          children: [
            ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Image.asset(
                  'assets/images/user_img.png',
                  fit: BoxFit.contain,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(name),
          ],
        ),
      ),
      Flexible(
        flex: 2,
        child: RatingBar.builder(
          itemSize: 30,
          initialRating: 4,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.blue,
          ),
          onRatingUpdate: (rating) {
            print("yooooooooooooooooooooooooooooooooooooooooo");
            model.userRating[uid] = rating.toInt();
            print(model.userRating);
          },
        ),
      ),
    ],
  );
}
