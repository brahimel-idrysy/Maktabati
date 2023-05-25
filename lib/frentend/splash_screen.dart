import 'package:flutter/material.dart';
import 'package:flutter_application_1/frentend/home_screen.dart';
import 'package:flutter_application_1/frentend/login_screen.dart';
import 'package:flutter_application_1/frentend/registre_screen.dart';
import 'package:flutter_svg/svg.dart';

import '../backend/dbservices.dart';

class splashPage extends StatefulWidget {
  static const String screenroute = 'splash_screen';
  @override
  State<splashPage> createState() => _splashPageState();
}

class _splashPageState extends State<splashPage> {
  String token = '';
  @override
  void initState() {
    super.initState();
    checkLoggedIn();
  }

  Future<void> checkLoggedIn() async {
    final storedToken = await DBServices.getToken();
    if (storedToken != null) {
      setState(() {
        token = storedToken;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      if (token.isEmpty) {
        //when user is not logged in redirect him to the login page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(253, 6, 164, 61),
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'images/logo.svg',
                height: 107,
                width: 132,
              )
            ]),
      ),
    );
  }
}
