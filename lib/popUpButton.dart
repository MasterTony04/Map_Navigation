import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:toast/toast.dart';

class PopButton extends StatefulWidget {
  final bool loggedIn;
  final authToggle;

  PopButton(this.loggedIn, this.authToggle);

  @override
  State<StatefulWidget> createState() {
    return PopButtonState();
  }
}

class PopButtonState extends State<PopButton> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  List<PopUp> signInPopUp = <PopUp>[
    const PopUp(title: Text('Sign In'), icon: Icon(Icons.input), id: 0),
  ];

  List<PopUp> signOutPopUp = <PopUp>[
    const PopUp(
      title: Text('Sign Out'),
      icon: Icon(Icons.input),
      id: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(
          Icons.menu,
        ),
        elevation: 2,
        onSelected: selected,
        itemBuilder: (BuildContext context) => widget.loggedIn
            ? signOutPopUp.map((PopUp popUp) {
                return PopupMenuItem(
                  value: popUp,
                  child: ListTile(
                    leading: popUp.icon,
                    title: popUp.title,
                  ),
                );
              }).toList()
            : signInPopUp.map((PopUp popUp) {
                return PopupMenuItem(
                  value: popUp,
                  child: ListTile(
                    leading: popUp.icon,
                    title: popUp.title,
                  ),
                );
              }).toList());
  }

  void _loginDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Login"),
          content: Container(
            height: 170,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username"),
                TextField(
                  controller: userName,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                Text("Password"),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Login"),
              onPressed: () {
                ParseUser(userName.text, password.text, '')
                    .login()
                    .then((value) {
                  widget.authToggle(true);
                  Toast.show(
                    'Login successful',
                    context,
                  );
                  Navigator.of(context).pop();
                });
              },
            ),
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void selected(PopUp popUp) {
    if (popUp.id == 0) {
//Navigator.push(context, MaterialPageRoute(builder: (_)=>OrderRecipientProfile()));
      _loginDialog();
    }
    if (popUp.id == 1) {
      ParseUser.currentUser().then(
          (val) => val.logout().then((value) => widget.authToggle(false)));
    }
  }
}

class PopUp {
  final Text title;
  final Icon icon;
  final int id;

  const PopUp({this.title, this.icon, this.id});
}
