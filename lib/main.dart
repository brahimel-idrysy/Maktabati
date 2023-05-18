import 'package:flutter/material.dart';
import 'package:flutter_application_1/frentend/home_screen.dart';
import 'package:flutter_application_1/frentend/login_screen.dart';
import 'package:flutter_application_1/frentend/splash_screen.dart';

import 'frentend/book_detail_screen.dart';
import 'frentend/editProfile_screen.dart';
import 'frentend/profile_screen.dart';
import 'frentend/registre_screen.dart';
import 'frentend/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrePage(),
    );
  }
}
