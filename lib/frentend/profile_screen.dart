import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/frentend/login_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../backend/dbservices.dart';
import 'SearchPage.dart';
import 'categories_screen.dart';
import 'card_screen.dart';
import 'category_books_screen.dart';
import 'editProfile_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

import 'package:http/http.dart' as http;

import 'book_detail_screen.dart';
import 'book_list_screen.dart';

class profilePage extends StatefulWidget {
  static const String screenroute = 'profile_screen';

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  String token = '';
  int? nApogee;
  String? nom;
  String? prenom;
  Map<String, dynamic> decodedToken = {};
  @override
  void initState() {
    super.initState();
    _getToken();
  }

  void _getToken() async {
    final gettoken = await DBServices.getToken();
    setState(() {
      token = gettoken!;
    });
    decodedToken = JwtDecoder.decode(token);
    // Access the user information from the decoded token
    nApogee = decodedToken['n_apogee'];
    nom = decodedToken['nom'];
    prenom = decodedToken['prenom'];
  }

  // Remove token from shared preferences
  Future<void> logout() async {
    await DBServices.deleteToken();

    // Perform any necessary cleanup or navigation
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(300, 0, 0, 0),
                child: FloatingActionButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => editProfile(),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  child: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('images/user.png'),
                radius: 50,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 248,
                height: 52,
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Full Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 60),
                        Text(
                          'N° Apogee',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '$nom $prenom',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Mukta Vaani",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "$nApogee",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Mukta Vaani",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  padding: EdgeInsets.only(bottom: 30),
                  width: 344,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(40, 0, 0, 0)),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromARGB(255, 217, 217, 217),
                              ),
                              child: const Icon(Icons.menu_book),
                            ),
                            const SizedBox(width: 20),
                            TextButton(
                              onPressed: () {},
                              child: const Material(
                                child: Row(
                                  children: [
                                    Text(
                                      "Your Books",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: "Mukta Vaani",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 60),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 0, 0)),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(255, 217, 217, 217),
                            ),
                            child: const Icon(Icons.settings),
                          ),
                          const SizedBox(width: 20),
                          TextButton(
                            onPressed: () {},
                            child: const Material(
                              child: Row(
                                children: [
                                  Text(
                                    "Setting",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Mukta Vaani",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 95),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 0, 0)),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(255, 217, 217, 217),
                            ),
                            child: const Icon(Icons.logout),
                          ),
                          const SizedBox(width: 20),
                          TextButton(
                            onPressed: logout,
                            child: const Material(
                              child: Row(
                                children: [
                                  Text(
                                    "Log out",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Mukta Vaani",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 9,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home_outlined),
                iconSize: 30,
                color: const Color.fromARGB(157, 6, 164, 61),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.library_books_outlined),
                iconSize: 30,
                color: const Color.fromARGB(157, 6, 164, 61),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => bookListPage(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_outline),
                iconSize: 30,
                color: const Color.fromARGB(157, 6, 164, 61),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritePage(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                iconSize: 30,
                color: const Color.fromARGB(157, 6, 164, 61),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardPage(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.person),
                iconSize: 30,
                color: const Color.fromARGB(255, 6, 164, 61),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => profilePage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
