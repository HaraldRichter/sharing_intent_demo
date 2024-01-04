import 'package:flutter/material.dart';
import 'package:sharing_intent_demo/home_screen.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';


import 'init_data.dart';

const String homeRoute = "home";
const String showDataRoute = "showData";

Future<InitData> init() async {
  String sharedText = "";
  String routeName = homeRoute;

  return InitData(sharedText, routeName);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitData initData = await init();



  runApp(MyApp(initData: initData));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initData});
  final InitData initData;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sharing Intent Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case homeRoute:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      },
      initialRoute: widget.initData.routeName,
    );
  }
}

