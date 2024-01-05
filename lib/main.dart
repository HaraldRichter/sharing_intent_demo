import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:sharing_intent_demo/home_screen.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:sharing_intent_demo/route_generator.dart';

import 'error_screen.dart';


// import 'init_data.dart';
//
const String homeRoute = "home";
const String showDataRoute = "showData";
//
// Future<InitData> init() async {
//   String sharedText = "";
//   String routeName = homeRoute;
//
//   return InitData(sharedText, routeName);
// }

void main() async {
 //  WidgetsFlutterBinding.ensureInitialized();
 //  InitData initData = await init();
 //
 // String? sharedValue = await FlutterSharingIntent.instance.getInitialSharing();

  // runApp(MyApp((initData: initData));
      runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, /*required this.initData*/});
  // final InitData initData;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late StreamSubscription _intentDataStreamSubscription;
  List<SharedFile>? list;
  @override
  void initState() {
    super.initState();
    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = FlutterSharingIntent.instance.getMediaStream()
        .listen((List<SharedFile> value) {
      setState(() {
        list = value;
      });
      print("Shared: getMediaStream ${value.map((f) => f.value).join(",")}");
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    FlutterSharingIntent.instance.getInitialSharing().then((List<SharedFile> value) {
      print("Shared: getInitialMedia ${value.map((f) => f.value).join(",")}");
      setState(() {
        list = value;
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sharing Intent Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }
}

