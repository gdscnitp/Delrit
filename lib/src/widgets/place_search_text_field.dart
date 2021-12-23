import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ride_sharing/constant/text_field_style.dart';
import 'package:ride_sharing/src/models/map_models.dart';
import 'package:ride_sharing/src/screens/address_search.dart';
import 'package:uuid/uuid.dart';

Widget placeSearchTextField({
  required TextEditingController controller,
  FocusNode? focusNode,
  required String label,
  required String hint,
  required double width,
  required Icon prefixIcon,
  required BuildContext context,
  Widget? suffixIcon,
  required Function(Suggestion?) locationCallback,
}) {
  return SizedBox(
    width: width * 0.8,
    child: TextField(
      // onChanged: (value) {
      // locationCallback(value);
      // },
      onTap: () async {
        final Position currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
        );
        final sessionToken = const Uuid().v4();
        final result = await showSearch(
          context: context,
          delegate: AddressSearch(sessionToken, currentLocation),
        );
        print(result.toString());
        locationCallback(result);
        controller.text = result!.description;
      },
      controller: controller,
      focusNode: focusNode,
      decoration: kTextFieldStyle(
          prefixIcon: const Icon(Icons.person), label: label, hint: hint),
    ),
  );
}

Widget inputFormField({
  // required TextEditingController controller,
  // FocusNode? focusNode,
  required String label,
  //required String hint,
  //required BuildContext context,
}) {
  return SizedBox(
    child: TextFormField(
      // onChanged: (value) {
      // locationCallback(value);
      // },
      onTap: () {},
      // controller: controller,
      // focusNode: focusNode,
      decoration: kTextFormFieldStyle(
        label: label,
        hint: 'Type here...',
      ),
    ),
  );
}
