import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/widgets/AccountWidget.dart';
import '../constants.dart';

class Settings extends StatefulWidget {
  const Settings();

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isLogged;
  String  email;
  String fullname;
  int level;
  String location;

  @override
  void initState() {
    super.initState();
    _isLogged();
  }

  _isLogged(){
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      setState(() {
        isLogged = !(user == null ?? false);
      });
    });
  }

  _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  RaisedButton sessionButton() {

    return !(isLogged ?? false)
        ? RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child:
                Text(getTranslated(context, 'log_in'), style: TextStyle(color: kTextColor)),
            color: kPrimaryColor,
          )
        : RaisedButton(
            onPressed: () {
              _logout();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
            color: Colors.redAccent,
            child: Text(getTranslated(context, 'close_session')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AccountWidget(fullname: fullname, email: email, level: level, location: location, isLogged: (isLogged ?? false)),
              Spacer(),
              Divider(color: kTextColor),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.bottomCenter, child: sessionButton()))
            ],
          )),
    );
  }
}
