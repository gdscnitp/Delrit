import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/view/complete_profile_viewmodel.dart';
import 'package:uuid/uuid.dart';
import '../../address_search.dart';

class Header extends StatelessWidget {
  final CompleteProfileViewModel model;
  const Header({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: App(context).appHeight(180),
          child: Image.asset(
            'assets/images/bg_map.png',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: App(context).appWidth(10),
              vertical: App(context).appHeight(5)),
          child: Container(
            width: App(context).appWidth(80),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextFormField(
              controller: model.addressController,
              onTap: () async {
                final Position currentLocation =
                    await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.medium,
                );
                final sessionToken = const Uuid().v4();
                final result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken, currentLocation),
                );
                model.updateLocation(result!.description);
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 10.0),
                hintText: 'Pick your location',
                hintStyle: const TextStyle(
                  fontSize: 15,
                ),
                prefixIcon: const Icon(
                  Icons.menu,
                  size: 35,
                ),
                suffixIcon: GestureDetector(
                  onTap: () async {
                    final result =
                        await Navigator.pushNamed(context, "/choose-location");
                    print(result);
                    print("============================");
                    model.updateLocation(result.toString());
                  },
                  child: const Icon(
                    Icons.gps_fixed,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
