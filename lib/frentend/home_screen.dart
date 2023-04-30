import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 233),
      body: Stack(
        children: [
          Image.asset('images/background.jpg'),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 70, 22, 0),
            child: Material(
              elevation: 20.0,
              shadowColor: Color.fromARGB(120, 0, 0, 0),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: Icon(Icons.search_outlined),
                  suffixIcon: Icon(Icons.mic_outlined),
                  hintText: 'Search by name, author...',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 183, 183, 183),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
