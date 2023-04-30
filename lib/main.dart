import 'package:flutter/material.dart';
import 'package:flutter_application_1/frentend/home_screen.dart';
import 'package:flutter_application_1/frentend/login_screen.dart';
import 'package:flutter_application_1/frentend/splash_screen.dart';

import 'frentend/registre_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: registrePage(),
    );
  }
}
