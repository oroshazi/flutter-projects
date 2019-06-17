import 'package:flutter/material.dart';
import 'package:nevnapp/widgets/bottom_navigation.widget.dart';

class ScreenLayout extends StatelessWidget {
  final Widget body;

  ScreenLayout({this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
