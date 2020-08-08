import 'package:flutter/material.dart';

class PopButton extends StatefulWidget {
final bool loggedIn;
PopButton(this.loggedIn);
  @override
  State<StatefulWidget> createState() {
    return PopButtonState();
  }
}

class PopButtonState extends State<PopButton> {


  List<PopUp> signInPopUp = <PopUp>[
    const PopUp(title: Text('Sign In'), icon: Icon(Icons.input), id: 0),
  ];

  List<PopUp> signOutPopUp = <PopUp>[
    const PopUp(title: Text('Sign Out'), icon: Icon(Icons.input), id: 1),
  ];
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(
          Icons.menu,
        ),
        elevation: 2,
        onSelected: selected,
        itemBuilder: (BuildContext context) => widget.loggedIn?signOutPopUp.map((PopUp popUp) {
          return PopupMenuItem(
            value: popUp,
            child: ListTile(
              leading: popUp.icon,
              title: popUp.title,
            ),
          );
        }).toList():signInPopUp.map((PopUp popUp) {
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
            width: MediaQuery.of(context).size.width*0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username"),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                ),
                Text("Password"),
                TextField(
                  obscureText:true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
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

    }
  }
}

class PopUp{
  final Text title;
  final Icon icon;
  final int id;

  const PopUp({this.title, this.icon, this.id});

}