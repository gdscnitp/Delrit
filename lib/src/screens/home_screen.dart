import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart' as config;
import 'package:ride_sharing/src/widgets/app_drawer.dart';
import 'package:ride_sharing/src/screens/home_screen/components/next_rider_bottom_sheet.dart';
import 'package:ride_sharing/src/screens/home_screen/components/ride_completed_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Notification"),
            content: const Text("yoo"),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    });
  }

  void _handleMessage(RemoteMessage message) {
    print("Handling Here");
  }

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Container(
          height: config.getProportionateScreenHeight(310),
          child: nextRiderBottomSheet(context),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    config.SizeConfig().init(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: config.ThemeColors().mainColor(1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              Navigator.pushNamed(context, '/available-drivers');
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalSheet(context);
          //Navigator.pushNamed(context, '/detail');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
