import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class splashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
