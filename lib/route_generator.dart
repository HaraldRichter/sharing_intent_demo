import 'package:flutter/material.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:sharing_intent_demo/home_screen.dart';
import 'package:sharing_intent_demo/share_screen.dart';
import 'package:sharing_intent_demo/third_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case 'shareScreen':
      // Validation of correct data type
        if (args is List<SharedFile>) {
          return MaterialPageRoute(
            builder: (_) => ShareScreen(
              sharedFiles: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case 'thirdScreen':
        if (args is String?) {
          return MaterialPageRoute(
            builder: (_) => ThirdScreen(
              someText: args,
            ),
          );
        }
        return _errorRoute();
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}