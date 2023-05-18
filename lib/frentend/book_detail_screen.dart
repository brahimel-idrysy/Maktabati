import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/frentend/profile_screen.dart';

import 'package:http/http.dart' as http;

import 'book_list_screen.dart';
import 'home_screen.dart';

class Book_Detail extends StatelessWidget {
  final CardItem item;
  const Book_Detail({
    Key? key,
    required this.item,
  }) : super(key: key);
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
                    padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
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
                    height: 700,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 23,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0x4c06ff5a),
                            ),
                            child: const Text(
                              "Finance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 4, 94, 34),
                                fontSize: 14,
                                fontFamily: "Mukta_Vaani_Medium",
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item.subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color.fromARGB(155, 110, 110, 110),
                              fontSize: 14,
                              fontFamily: "Mukta_Vaani_Light",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontFamily: "Mukta_Vaani_Bold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(118, 0, 110, 0),
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
                            child: const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Pages',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Mukta_Vaani_Light",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 48),
                                      Text(
                                        'Price',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: "Mukta_Vaani_Light",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 48),
                                      Text(
                                        'Quantity',
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
                                        "198",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Mukta_Vaani_Medium",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 59),
                                      Text(
                                        "51",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Mukta_Vaani_Medium",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 63),
                                      Text(
                                        "79",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Mukta_Vaani_Medium",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 80),
                                      Text(
                                        "74466",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
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
                                      item.urlImage,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "images/rich sommaire.png",
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
                          const Text(
                            "Rich Dad Poor Dad is Robert's story of growing up with two dads — his real father and the father of his best friend, his rich dad — and the ways in which both men shaped his thoughts about money and investing. The book explodes the myth that you need to earn a high income to be rich and explains the difference between working for money and having your money work for you.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Poppins_Reguler",
                              fontWeight: FontWeight.w600,
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
                        child: Image.asset(item.urlImage),
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
              icon: const Icon(Icons.favorite_outline),
              iconSize: 30,
              color: const Color.fromARGB(157, 6, 164, 61),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => profilePage(),
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
    );
  }
}
