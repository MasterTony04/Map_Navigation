import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:omarymap/leakageListBody.dart';
import 'package:omarymap/popUpButton.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:toast/toast.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController descriptionText = TextEditingController();
  TextEditingController fullNameText = TextEditingController();
  bool loggedIn = false;
  List<Marker> _markers;
  LatLng _point;
  TileLayerOptions customMapLayer = TileLayerOptions();
  double _lat;
  double _lng;
  Position _currentPosition;

  void onSubmit() {
    Toast.show('Reporting Leakage...', context, duration: Toast.LENGTH_LONG);
    var report = ParseObject('Report')
      ..set('fullName', fullNameText.text)..set(
          'description', descriptionText.text)..set('latitude', _lat)..set(
          'longitude', _lng);

    report.save().then((value) {
      print(value.success);
      Toast.show(
        'Leakage reported successfully',
        context,
      );
      descriptionText.clear();
      fullNameText.clear();
    }).catchError((error) {
      Toast.show('Error Reporting Leakage', context,
          duration: Toast.LENGTH_SHORT);
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  Future<void> onDownload() async {
    ParseCloudFunction downloadFunction = ParseCloudFunction('generateReport');
    ParseResponse result = await downloadFunction.execute();
    if (result.success) {
      print(result.result);

      final taskId = await FlutterDownloader.enqueue(url: result.result.url,
          savedDir: '/reports',
          showNotification: true,
          openFileFromNotification: true);
    } else {
      print(result.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Water Leakage Reporting"),
        centerTitle: true,
        actions: [
          PopButton(loggedIn, (value) {
            setState(() {
              loggedIn = value;
            });
          })
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: loggedIn
              ? LeakageList()
              : ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Image.asset("assets/waterLogo.png"),
              ),
              Text("Please describe the Leakage"),
              SizedBox(
                height: 10,
              ),
              Center(
                child: TextField(
                  controller: descriptionText,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Full Name"),
                  Text(
                    " (optional)",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Center(
                child: TextField(
                  controller: fullNameText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    child: Text("Cancel"),
                    color: Colors.red,
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text("Submit"),
                    color: Colors.blue,
                    onPressed: () {
                      onSubmit();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: loggedIn
          ? FloatingActionButton(
        onPressed: () {
          onDownload()
              .then((_) => Toast.show('Report Downloaded', context));
        },
        child: Icon(Icons.file_download),
      )
          : null,
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getCurrentLocationMarker();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getCurrentLocationMarker() {
    setState(() {
      _lat = _currentPosition.latitude;
      _lng = _currentPosition.longitude;
      _point = LatLng(_lat, _lng);
      _markers[0] = Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        builder: (ctx) =>
        new Container(
            child: Icon(
              Icons.location_on,
              size: 50.0,
            )),
      );
    });
  }
}
