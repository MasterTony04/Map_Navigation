import 'package:flutter/material.dart';
import 'package:omarymap/leakageListBody.dart';
import 'package:omarymap/popUpButton.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController descriptionText = TextEditingController();
  TextEditingController fullNameText = TextEditingController();
  bool loggedIn =true;
  List<Marker> _markers;
  LatLng _point;
  TileLayerOptions customMapLayer = TileLayerOptions();
  double _lat;
  double _lng;
  Position _currentPosition;

  @override
  void initState() {
   _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Water Leakage Reporting"),
        centerTitle: true,
        actions: [
         PopButton(loggedIn)
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8.0),
          child: loggedIn?LeakageList():ListView(
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
                  Text(" (optional)",style: TextStyle(color: Colors.grey),),
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
                    onPressed: (){},
                  ),
                  FlatButton(
                    child: Text("Submit"),
                    color: Colors.blue,
                    onPressed: (){
                      print(descriptionText.text);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: loggedIn?FloatingActionButton(
        onPressed: (){
          setState(() {
            print("@@@@@@@@");
            print(_lat);
            print(_lng);
          });

        },
        child: Icon(Icons.file_download),
      ):null,
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getCurrentLocationMarker();
        print("@@@@@@@@@@@");
        print(_lat);
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
        builder: (ctx) => new Container(
            child: Icon(
              Icons.location_on,
              size: 50.0,
            )),
      );
    });
  }
}
