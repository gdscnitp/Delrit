import 'package:ride_sharing/src/screens/add_ride.dart';
import 'package:ride_sharing/src/screens/choose_location.dart';
import 'package:ride_sharing/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/src/screens/landing_page.dart';
import 'package:ride_sharing/src/screens/login_page.dart';
import 'package:ride_sharing/src/screens/map_test.dart';
import 'package:ride_sharing/src/screens/search_riders.dart';
import 'package:ride_sharing/src/screens/splash_screen.dart';
import 'package:ride_sharing/src/screens/complete_profile.dart';

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
      case '/addride':
        return MaterialPageRoute(builder: (_) => const AddRide());
      case '/searchrider':
        return MaterialPageRoute(builder: (_) => const SearchRider());
      case '/complete-profile':
        return MaterialPageRoute(builder: (_) => const CompleteProfile());
      case '/choose-location':
        return MaterialPageRoute(builder: (_) => const ChooseLocation());
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
