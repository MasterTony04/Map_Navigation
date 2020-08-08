import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:time_formatter/time_formatter.dart';

class LeakListItem extends StatelessWidget {
  final ParseObject report;

  LeakListItem(this.report);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(report.get('fullName')),
          subtitle: Text(report.get('description')),
          trailing: Text(formatTime(report.get('createdAt').millisecondsSinceEpoch)),
          onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (_)=> ReportDetails(report: report,)) )
        ),
        Divider()
      ],
    );
  }
}

class ReportDetails extends StatelessWidget {
  final ParseObject report;

  const ReportDetails({Key key, this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(report.get('fullName')),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(report.get('description'), textAlign: TextAlign.justify,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Latitude: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),), Text(report.get('latitude').toString())
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Longitude: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),), Text(report.get('longitude').toString())
              ],),
            ),
          ],
        ),
      ),
    );
  }
}

