import 'package:flutter/material.dart';
import 'package:omarymap/leakListItem.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class LeakageList extends StatefulWidget {
  @override
  _LeakageListState createState() => _LeakageListState();
}

class _LeakageListState extends State<LeakageList> {
  var queryBuilder = QueryBuilder<ParseObject>(ParseObject('Report'))
    ..orderByDescending('createdAt');

  @override
  Widget build(BuildContext context) {
    return ParseLiveListWidget(
      query: queryBuilder,
      listLoadingElement: Center(child: CircularProgressIndicator()),
      childBuilder: (context, snapshot) {
        if (snapshot.hasData) {
          return LeakListItem(snapshot.loadedData);
        } else {
          return Text('Wait...');
        }
      },
    );
  }
}
