import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/screens/address_search.dart';
import 'package:ride_sharing/src/widgets/place_search_text_field.dart';
import 'package:ride_sharing/view/complete_profile_viewmodel.dart';
import 'package:uuid/uuid.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CompleteProfileViewModel>(builder: (context, model, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Flexible(flex: 1, child: Header(model: model)),
            Flexible(flex: 3, child: Body(model: model)),
          ],
        ),
      );
    });
  }
}

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
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
                hintText: 'Pick your current location',
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
                prefixIcon: Icon(
                  Icons.menu,
                  size: 35,
                ),
                suffixIcon: Icon(
                  Icons.gps_fixed,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  final CompleteProfileViewModel model;
  Body({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: App(context).appWidth(10.0),
          vertical: App(context).appHeight(5)),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Text(
                'Complete Your Profile',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: App(context).appWidth(6.0),
                    ),
              ),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Name', controller: model.nameController),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Email', controller: model.emailController),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Phone', controller: model.phoneController),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(
                  label: 'Gender', controller: model.genderController),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Age', controller: model.ageController),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              ElevatedButton(
                onPressed: model.save,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: App(context).appWidth(20.0),
                    vertical: App(context).appHeight(1.5),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save & Continue',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
