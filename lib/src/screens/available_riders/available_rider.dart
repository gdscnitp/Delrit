import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/available_riders_viewmodel.dart';
import 'components/body.dart';

class AvailableRiders extends StatelessWidget {
  const AvailableRiders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AvailableRidersViewModel>(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                'Available Riders',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
            ),
            body: Body(context, model),
          );
        });
  }
}
