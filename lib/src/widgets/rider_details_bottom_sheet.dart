import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/models/riders.dart';
import 'package:ride_sharing/view/search_rider_viewmodel.dart';

class RiderDetailsBottomSheet extends StatefulWidget {
  final Rider rider;
  const RiderDetailsBottomSheet({Key? key, required this.rider})
      : super(key: key);
  @override
  _RiderDetailsBottomSheetState createState() =>
      _RiderDetailsBottomSheetState();
}

class _RiderDetailsBottomSheetState extends State<RiderDetailsBottomSheet> {
  String buttonText = "Accept Ride";
  @override
  Widget build(BuildContext context) {
    return BaseView<SearchRiderViewModel>(
      builder: (context, model, child) => Column(
        children: [
          ListTile(
            title: Text(widget.rider.name),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    buttonText = "Ride Accepted";
                  });
                  model.acceptRide(widget.rider);
                },
                child: Text(buttonText),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Chat with Rider"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
