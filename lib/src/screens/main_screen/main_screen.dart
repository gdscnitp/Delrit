import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/enum/view_state.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/models/trips.dart';
import 'package:ride_sharing/src/models/user.dart';
import 'package:ride_sharing/src/screens/main_screen/components/no_ride.dart';
import 'package:ride_sharing/src/screens/main_screen/components/ride_ended.dart';
import 'package:ride_sharing/src/screens/ride_details/ride_details.dart';
import 'package:ride_sharing/src/widgets/app_drawer.dart';
import 'package:ride_sharing/src/widgets/driver_request_bottomsheet.dart';
import 'package:ride_sharing/src/widgets/show_exit_popup.dart';
import 'package:ride_sharing/view/main_screen_viewmodel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  Widget? bottomSheet;
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: BaseView<MainScreenViewModel>(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          print("reloading here");
          switch (model.rideState) {
            case RideState.NO_RIDE:
              bottomSheet = const NoRideBS();
              break;
            case RideState.RIDE_CONFIRMED:
              bottomSheet = RideDetails(model);
              break;
            case RideState.RIDE_STARTED:
              bottomSheet = RideDetails(model);
              break;
            case RideState.RIDE_ENDED:
              bottomSheet = RideEndedBottomSheet(model);
              break;
            default:
          }
          return SafeArea(
            child: Scaffold(
              key: model.scaffoldkey,
              backgroundColor: Colors.yellow[50],
              drawer: AppDrawer(),
              body: Stack(
                children: [
                  GoogleMap(
                    myLocationEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: false,
                    markers: Set<Marker>.of(model.markers),
                    polylines: Set<Polyline>.of(model.polylines.values),
                    initialCameraPosition: model.initialLocation,
                    onMapCreated: (GoogleMapController controller) {
                      model.mapController = controller;
                      // Delay of 3 second
                      Future.delayed(const Duration(seconds: 2), () {
                        model.getCurrentTripMap();
                      });
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/main", (route) => false);
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                  ),
                  DraggableScrollableSheet(
                    initialChildSize: 0.35,
                    minChildSize: 0.35,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Card(
                          elevation: 12.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          margin: const EdgeInsets.all(0),
                          child: bottomSheet,
                        ),
                      );
                    },
                  ),
                ],
              ),
              // body: GoogleMap(
              //   myLocationEnabled: true,
              //   compassEnabled: true,
              //   tiltGesturesEnabled: false,
              //   markers: Set<Marker>.of(model.markers),
              //   polylines: Set<Polyline>.of(model.polylines.values),
              //   initialCameraPosition: model.initialLocation,
              //   onMapCreated: (GoogleMapController controller) {
              //     model.mapController = controller;
              //     model.getCurrentLocation();
              //   },
              // ),
              // bottomSheet: model.state == ViewState.Busy
              //     ? const Center(child: CircularProgressIndicator())
              //     : bottomSheet,
            ),
          );
        },
      ),
    );
  }
}
