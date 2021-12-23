import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/widgets/place_search_text_field.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: const [
          Flexible(flex: 1, child: Header()),
          Flexible(flex: 3, child: Body()),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

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
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
              inputFormField(label: 'Name'),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Email'),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Phone'),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Gender'),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Age'),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              ElevatedButton(
                onPressed: () {},
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
