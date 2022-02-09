import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart' as config;
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/models/user.dart';
import 'package:ride_sharing/src/screens/rider_details/components/reusable_button.dart';
import 'package:ride_sharing/src/screens/test_screen.dart';
import 'package:ride_sharing/src/screens/user_profile/user_profile.dart';
import 'package:ride_sharing/src/widgets/app_drawer.dart';
import 'package:ride_sharing/view/home_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }

    if (message.data["requestType"] == "RequestByDriver" ||
        message.data["requestType"] == "RequestByRider") {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        builder: (builder) {
          return DriverRequestBottomSheet(message.data);
        },
      );
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }

    if (message.data["requestType"] == "Chat") {
      var data =
          (await db.collection('users').doc(message.data["senderUid"]).get())
              .data();
      UserProfileModel user = UserProfileModel.fromJson(data!);
      print("here===");
      print(user.name);
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/chats",
        (route) => true,
        arguments: user,
      );
    } else {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        builder: (builder) {
          return DriverRequestBottomSheet(message.data);
        },
      );
    }
  }

  // class ShowTripStatus extends StatefulWidget {
  //   const ShowTripStatus({ Key? key }) : super(key: key);

  //   @override
  //   _ShowTripStatusState createState() => _ShowTripStatusState();
  // }

  // class _ShowTripStatusState extends State<ShowTripStatus> {
  //   @override
  //   Widget build(BuildContext context) {
  //     return Container(

  //     );
  //   }
  // }

  // void showTripModalSheet(BuildContext context) {
  //   showModalBottomSheet<dynamic>(
  //       context: context,
  //       isScrollControlled: true,
  //       builder: (builder) {
  //         return BaseView<HomeScreenViewModel>(
  //             onModelReady: (model) => model.init(),
  //             builder: (context, model, child) {
  //               return Container(
  //                 height: config.getProportionateScreenHeight(310),
  //                 child: Text(model.driverStatus),
  //               );
  //             });
  //       });
  // }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    // showTripModalSheet(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    config.SizeConfig().init(context);
    return BaseView<HomeScreenViewModel>(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            bottomSheet: Row(
              children: [
                Text(model.driverStatus),
                ElevatedButton(
                  child: Text(model.rideStatusText),
                  onPressed: () {
                    model.generateAndSaveOtp();
                  },
                )
              ],
            ),

            drawer: const AppDrawer(),
            appBar: AppBar(
              title: const Text('Home'),
              //backgroundColor: config.ThemeColors().mainColor(1),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.driverStatus),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/landing');
                    },
                    child: const Text('Landing Page'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/test');
                    },
                    child: const Text('Map Test'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/post-ride');
                    },
                    child: const Text('Post Ride'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/searchrider');
                    },
                    child: const Text('Search Rider'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/addVehicle');
                    },
                    child: const Text('Add Vehicle'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/complete-profile');
                    },
                    child: const Text('Complete Profile'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/user-profile');
                    },
                    child: const Text('User Profile'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/available-riders');
                    },
                    child: const Text('Available Riders'),
                  ),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/rider-details');
                  //   },
                  //   child: const Text('Rider Details'),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/available-drivers',
                        arguments: "aOG5i3YIccmhMnADEEqb",
                      );
                    },
                    child: const Text('Available Drivers'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/chats');
                    },
                    child: const Text('Chats'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ride-details');
                    },
                    child: const Text('Ride Details'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/access-permission');
                    },
                    child: const Text('Access Permission'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TestScreen()));
                    },
                    child: const Text('Test Screen'),
                  ),
                ],
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     _showModalSheet(context);
            //     //Navigator.pushNamed(context, '/detail');
            //   },
            //   child: const Icon(Icons.add),
            // ),
          );
        });
  }
}

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
