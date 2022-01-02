import 'package:ride_sharing/src/screens/access_permission_page.dart';
import 'package:ride_sharing/src/screens/available_drivers/available_drivers.dart';
import 'package:ride_sharing/src/screens/available_riders/available_rider.dart';
import 'package:ride_sharing/src/screens/driver_details/driver_details.dart';
import 'package:ride_sharing/src/screens/rider_details/rider_details.dart';
import 'package:ride_sharing/src/screens/chat_screen/chat_screen.dart';
import 'package:ride_sharing/src/screens/choose_location.dart';
import 'package:ride_sharing/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/src/screens/landing_page.dart';
import 'package:ride_sharing/src/screens/login_page.dart';
import 'package:ride_sharing/src/screens/map_test.dart';
import 'package:ride_sharing/src/screens/ride_details/ride_details.dart';
import 'package:ride_sharing/src/screens/nearby_riders.dart';
import 'package:ride_sharing/src/screens/search_riders.dart';
import 'package:ride_sharing/src/screens/splash_screen.dart';
import 'package:ride_sharing/src/screens/complete_profile/complete_profile.dart';
import 'package:ride_sharing/src/screens/user_profile/user_profile.dart';
import 'package:ride_sharing/src/screens/verification.dart';
import 'package:ride_sharing/src/screens/post_ride/post_ride.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case "/landing":
        return MaterialPageRoute(builder: (_) => const Landing_Page());
      case '/test':
        return MaterialPageRoute(builder: (_) => const MapTest());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/phone-verification':
        return MaterialPageRoute(builder: (_) => const PhoneScreen());
      case '/searchrider':
        return MaterialPageRoute(builder: (_) => const SearchRider());
      case '/complete-profile':
        return MaterialPageRoute(builder: (_) => const CompleteProfile());
      case '/choose-location':
        return MaterialPageRoute(builder: (_) => const ChooseLocation());
      case '/nearby-riders':
        return MaterialPageRoute(builder: (_) => NearbyRiders(args: args));
      case '/user-profile':
        return MaterialPageRoute(builder: (_) => const UserProfile());
      case '/ride-details':
        return MaterialPageRoute(builder: (_) => const RideDetails());
      case '/chats':
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case '/post-ride':
        return MaterialPageRoute(builder: (_) => const PostRide());
      case '/access-permission':
        return MaterialPageRoute(builder: (_) => const AccessPermission());
      case '/available-drivers':
        return MaterialPageRoute(builder: (_) => const AvailableDrivers());
      case '/available-riders':
        return MaterialPageRoute(builder: (_) => const AvailableRiders());
      case '/rider-details':
        return MaterialPageRoute(builder: (_) => const RiderDetails());
      case '/driver-details':
        return MaterialPageRoute(builder: (_) => const DriverDetails());
//      case '/second':
//      // Validation of correct data type
//        if (args is String) {
//          return MaterialPageRoute(
//            builder: (_) => SecondPage(
//              data: args,
//            ),
//          );
//        }
//        // If args is not of the correct type, return an error page.
//        // You can also throw an exception while in development.
//        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
