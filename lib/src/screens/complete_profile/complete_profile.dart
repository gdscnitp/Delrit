import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/complete_profile_viewmodel.dart';
import 'components/body.dart';
import 'components/header.dart';

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
            Flexible(
                flex: 3,
                child: Body(
                  model: model,
                )),
          ],
        ),
      );
    });
  }
}
