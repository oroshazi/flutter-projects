import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Text("settings"),
          Text("change language"),
          Text("change theme"),
          Text("change start of the week"),
          Text("Notification settings!!")
        ],
      ),
    );
  }
}
