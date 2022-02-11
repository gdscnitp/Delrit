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
  required TextEditingController controller,
  required TextInputType Ktype,
  required String error_msg,
  //required String hint,
  //required BuildContext context,
}) {
  return SizedBox(
    child: TextFormField(
      
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value){
        if (value!.isEmpty ) {
          return error_msg;
          
        } else {
          return null;
        }
      },
      keyboardType:Ktype,
      controller: controller,
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

Widget riderSearchTextField({
  required TextEditingController controller,
  required String msg,
  FocusNode? focusNode,
  required String label,
  required String hint,
  required double width,
  required Icon suffIcon,
  required BuildContext context,
  Widget? suffixIcon,
  required Function(String?) locationCallback,
}) {
  return SizedBox(
    width: width * 0.8,
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value){
        if (value!.isEmpty) {
          return msg;
          
        } else {
          return null;
        }
      },
      
      
      // onChanged: (value) {
      // locationCallback(value);
      // },
      onTap: () async {
        final Position currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
        );
        final sessionToken = const Uuid().v4();
        final result = await Navigator.pushNamed(context, "/choose-location");
        print(result.toString());
        locationCallback(result.toString());
        controller.text = result.toString();
      },
      controller: controller,
      focusNode: focusNode,
      decoration: kTextFieldStyle(
        suffixIcon: suffIcon,
        label: label,
        hint: hint,
        fillColor: Colors.grey[300],
        borderwidth: 0,
      ),
    ),
  );
}

Widget addVehicleStyle({
  required TextEditingController controller,
  required double width,
  required String hint,
}) {
  return SizedBox(
    width: 0.8 * width,
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        filled: true,
        fillColor: Colors.grey.shade300,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.blue.shade300,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(15),
      ),
    ),
  );
}
