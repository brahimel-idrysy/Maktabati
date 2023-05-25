import 'package:flutter/material.dart';

import 'book_list_screen.dart';
import 'card_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class FavoritePage extends StatefulWidget {
  static const String screenroute = 'favorite_screen';

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 233),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 270, top: 20),
                child: Text(
                  'Favorite',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: "Mukta_Vaani_Bold",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 600,
                height: 809,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 80, 0),
                      child: SizedBox(
                        height: 155,
                        width: 280,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 114,
                              height: 155,
                              child: Image.asset('images/1984.jpg'),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(130, 20, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '1984',
                                    style: TextStyle(
                                      fontFamily: "Mukta_Vaani_Bold",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'By George Orwell',
                                        style: TextStyle(
                                          color: Color(0x8c000000),
                                          fontSize: 14,
                                          fontFamily: "Mukta_Vaani_Medium",
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Icon(
                                        Icons.favorite,
                                        color: Color(0xdbff0000),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 80, 0),
                      child: SizedBox(
                        height: 155,
                        width: 280,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 114,
                              height: 155,
                              child: Image.asset('images/les miserables.jpg'),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(130, 20, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Les Miserables',
                                    style: TextStyle(
                                      fontFamily: "Mukta_Vaani_Bold",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'By Victor Hugo',
                                        style: TextStyle(
                                          color: Color(0x8c000000),
                                          fontSize: 14,
                                          fontFamily: "Mukta_Vaani_Medium",
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Icon(
                                        Icons.favorite,
                                        color: Color(0xdbff0000),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
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
                icon: const Icon(Icons.favorite),
                iconSize: 30,
                color: const Color.fromARGB(255, 6, 164, 61),
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
