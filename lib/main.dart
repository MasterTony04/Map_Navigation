import 'package:flutter/material.dart';
import 'package:omarymap/landingPage.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> initialize() async {
  await Parse().initialize('leakage-reporter', 'https://leakage-reporter.herokuapp.com/api', liveQueryUrl: 'ws://leakage-reporter.herokuapp.com/api');
  await FlutterDownloader.initialize(
      debug: true 
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initialize()
      .then((value) => runApp(MyApp()))
      .catchError((error){
        print(error);
        print('---------------------');
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leakage Reporter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
    );
  }
}
