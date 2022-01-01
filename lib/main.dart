import 'package:flutter/material.dart';
import 'package:fyp_ims/views/auth/landing_page.dart';

void main() async{
  runApp(MaterialApp(
    home: LandingPage(),
    theme: ThemeData(
      primarySwatch: Colors.indigo,
    ),
  ));
}