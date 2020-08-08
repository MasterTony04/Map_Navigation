import 'package:flutter/material.dart';

class LeakListItem extends StatelessWidget {
 final String fullName;
 final String description;
  LeakListItem(this.fullName, this.description);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(fullName),
          subtitle: Text(description),
          trailing: Text("20/08/2020"),
        ),
        Divider()
      ],
    );
  }
}
