import 'package:flutter/material.dart';
import 'package:omarymap/leakListItem.dart';

class LeakageList extends StatefulWidget {
  @override
  _LeakageListState createState() => _LeakageListState();
}

class _LeakageListState extends State<LeakageList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => LeakListItem("J.J Okocha","Ni Kimara"),

    );
  }
}
