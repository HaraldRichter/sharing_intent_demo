import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:sharing_intent_demo/home_screen.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:sharing_intent_demo/route_generator.dart';
import 'package:sharing_intent_demo/share_screen.dart';
import 'package:sharing_intent_demo/third_screen.dart';

import 'error_screen.dart';
/// ----------------------

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // For sharing images coming from outside the app while the app is closed
  List<SharedFile> sharedFilesList = await FlutterSharingIntent.instance.getInitialSharing();

  // For sharing images coming from outside the app while the app is in the memory
  if (sharedFilesList.isEmpty) {
    sharedFilesList = await FlutterSharingIntent.instance.getMediaStream().first;
  }

  String initialRouteName = sharedFilesList.isNotEmpty ? 'shareScreen' : '/';

  runApp(MyApp(initialRouteName: initialRouteName, sharedFilesList: sharedFilesList));
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.initialRouteName, required this.sharedFilesList});

  final String initialRouteName;
  late final List<SharedFile> sharedFilesList;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _intentDataStreamSubscription;

  @override
  void initState() {
    super.initState();

    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = FlutterSharingIntent.instance.getMediaStream().listen(
          (List<SharedFile> value) {
        setState(() {
          widget.sharedFilesList = value;
        });
        print("Shared: getMediaStream ${value.map((f) => f.value).join(",")}");
      },
      onError: (err) {
        print("getIntentDataStream error: $err");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sharing Intent Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: widget.initialRouteName,
      onGenerateRoute: (settings) {
        if (settings.name == 'shareScreen') {
          return MaterialPageRoute(
            builder: (_) => ShareScreen(sharedFiles: widget.sharedFilesList),
          );
        } else {
          return RouteGenerator.generateRoute(settings);
        }
      },
    );
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }
}



/// ----------------------
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//       runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//   late StreamSubscription _intentDataStreamSubscription;
//   List<SharedFile>? sharedFilesList;
//   String initialRouteName = '/';
//
//   @override
//   void initState() {
//     super.initState();
//     // For sharing images coming from outside the app while the app is in the memory
//     _intentDataStreamSubscription = FlutterSharingIntent.instance.getMediaStream()
//         .listen((List<SharedFile> value) {
//       setState(() {
//         sharedFilesList = value;
//         initialRouteName = 'shareScreen';
//       });
//       print("Shared: getMediaStream ${value.map((f) => f.value).join(",")}");
//     }, onError: (err) {
//       print("getIntentDataStream error: $err");
//     });
//
//     // For sharing images coming from outside the app while the app is closed
//     FlutterSharingIntent.instance.getInitialSharing().then((List<SharedFile> value) {
//       print("Shared: getInitialMedia ${value.map((f) => f.value).join(",")}");
//       setState(() {
//         sharedFilesList = value;
//         initialRouteName = 'shareScreen';
//       });
//     });
//   }
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sharing Intent Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
//         useMaterial3: true,
//       ),
//       initialRoute: initialRouteName,
//       onGenerateRoute: RouteGenerator.generateRoute,
//     );
//   }
//
//   @override
//   void dispose() {
//     _intentDataStreamSubscription.cancel();
//     super.dispose();
//   }
// }

