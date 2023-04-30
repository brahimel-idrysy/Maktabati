import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {required this.color, required this.title, required this.onPressed});
  final Color color;
  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(110, 8, 110, 8),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
          onPressed: () => onPressed,
          minWidth: 167,
          height: 51,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
