import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/src/screens/rider_details/components/reusable_button.dart';

class DriverRequestBottomSheet extends StatefulWidget {
  final Map<String, dynamic> message;
  const DriverRequestBottomSheet(this.message, {Key? key}) : super(key: key);

  @override
  _DriverRequestBottomSheetState createState() =>
      _DriverRequestBottomSheetState();
}

class _DriverRequestBottomSheetState extends State<DriverRequestBottomSheet> {
  String requesterName = "";
  final FirebaseFirestore db = FirebaseFirestore.instance;
  void getUserInfo(String uid) async {
    print(uid);
    var data = (await db.collection("users").doc(uid).get()).data();

    setState(() {
      requesterName = data!["name"];
    });
  }

  @override
  void initState() {
    super.initState();
    widget.message["requestType"] == "RequestByDriver"
        ? getUserInfo(widget.message["driverUid"])
        : getUserInfo(widget.message["riderUid"]);
  }

  void handleAccept() async {
    print("Accepted");
    var data =
        (await db.collection("trips").doc(widget.message["tripId"]).get())
            .data();
    var riders = data!["riders"] as List;

    var newRiders = riders.map((e) {
      if (e["riderUid"] == widget.message["riderUid"]) {
        e["riderStatus"] = "confirmed";
      }
      return e;
    }).toList();

    db.collection("trips").doc(widget.message["tripId"]).update({
      "riders": newRiders,
    });

    print(newRiders);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.message["requestType"] == "RequestByDriver"
                ? "You have asked to join $requesterName's trip"
                : "$requesterName has requested to join your trip",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              resuableButton(
                text: 'Deny',
                buttoncolor: Color(0xFFf46647),
                onPress: () {},
              ),
              resuableButton(
                text: 'Accept',
                buttoncolor: Color(0xFF65cb14),
                onPress: () {
                  handleAccept();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
