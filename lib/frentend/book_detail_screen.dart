import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/frentend/profile_screen.dart';

import 'package:http/http.dart' as http;

import '../backend/dbservices.dart';
import 'book_list_screen.dart';
import 'home_screen.dart';

class Book_Detail extends StatelessWidget {
  static const String screenroute = 'bookdetail_screen';
  final Livre book;
  Book_Detail({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 320, 10),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 40,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                    padding: const EdgeInsets.fromLTRB(20, 0, 15, 20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color: Colors.white,
                    ),
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                      child: Column(
                        children: [
                          Text(
                            book.AUTHEUR,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color.fromARGB(155, 110, 110, 110),
                              fontSize: 14,
                              fontFamily: "Mukta_Vaani_Light",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            book.TITRE,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontFamily: "Mukta_Vaani_Bold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(118, 10, 110, 0),
                            child: Row(
                              children: [
                                Container(
                                  width: 87,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromARGB(146, 244, 56, 56),
                                        Color(0xfff43838),
                                        Color(0xfaf43838),
                                        Color.fromARGB(146, 244, 56, 56)
                                      ],
                                    ),
                                  ),
                                  child: const Text(
                                    "Borrow Now",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "Mukta_Vaani_Bold",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 26,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xfff4e9e9),
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: 320,
                            height: 51,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: const Color(0xafd9d9d9),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        'Prix',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Mukta_Vaani_Light",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 48),
                                      Text(
                                        'Editeur',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: "Mukta_Vaani_Light",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 48),
                                      Text(
                                        'Date ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: "Mukta_Vaani_Light",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 48),
                                      Text(
                                        'Code',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: "Mukta_Vaani_Light",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${book.PRIX}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Mukta_Vaani_Medium",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 54),
                                      Text(
                                        book.EDITEUR,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Mukta_Vaani_Medium",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        "${book.DATE_EDITION}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Mukta_Vaani_Medium",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 48),
                                      Text(
                                        "${book.CODE}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Mukta_Vaani_Medium",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 150,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "images${book.PAGE_DE_GARDE}",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "images${book.SOMAIRE}",
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 290, 12),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                color: Color(0x9e000000),
                                fontSize: 14,
                                fontFamily: "Mukta_Vaani_Light",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              book.OBSERVATION,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: "Poppins_Reguler",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(150, 0, 150, 0),
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x3f000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.asset("images${book.PAGE_DE_GARDE}"),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                iconSize: 30,
                color: const Color.fromARGB(255, 6, 164, 61),
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
                icon: const Icon(Icons.shopping_cart_outlined),
                iconSize: 30,
                color: const Color.fromARGB(157, 6, 164, 61),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person_outlined),
                iconSize: 30,
                color: const Color.fromARGB(157, 6, 164, 61),
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
