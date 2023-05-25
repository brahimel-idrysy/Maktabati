import 'package:flutter/material.dart';

import 'card_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class bookListPage extends StatefulWidget {
  static const String screenroute = 'booklist_screen';
  @override
  State<bookListPage> createState() => _bookListPageState();
}

class _bookListPageState extends State<bookListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 233),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 240, top: 10),
                child: Text(
                  'Your Books',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Mukta_Vaani_Bold",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 380,
                      height: 103,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0x93ff0101),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(100, 20, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rich Dad Poor Dad',
                              style: TextStyle(
                                fontFamily: "Mukta_Vaani_Bold",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'By Robert T.Kiyosaki',
                              style: TextStyle(
                                color: Color(0x8c000000),
                                fontSize: 14,
                                fontFamily: "Mukta_Vaani_Medium",
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              '0 Days Left',
                              style: TextStyle(
                                color: Color(0x60000000),
                                fontSize: 14,
                                fontFamily: "Mukta_Vaani_Medium",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 6),
                      child: Container(
                        width: 71,
                        height: 105,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x3f000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'images/rich dad poor dad.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 380,
                      height: 103,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0x2bff0101),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(100, 20, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The First Days',
                              style: TextStyle(
                                fontFamily: "Mukta_Vaani_Bold",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'By Rhiannon Frater',
                              style: TextStyle(
                                color: Color(0x8c000000),
                                fontSize: 14,
                                fontFamily: "Mukta_Vaani_Medium",
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              '1 Days Left',
                              style: TextStyle(
                                color: Color(0x60000000),
                                fontSize: 14,
                                fontFamily: "Mukta_Vaani_Medium",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 6),
                      child: Container(
                        width: 71,
                        height: 105,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x3f000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'images/first day.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 380,
                      height: 103,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(100, 20, 0, 0),
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
                            Text(
                              'By George Orwell',
                              style: TextStyle(
                                color: Color(0x8c000000),
                                fontSize: 14,
                                fontFamily: "Mukta_Vaani_Medium",
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              '4 Days Left',
                              style: TextStyle(
                                color: Color(0x60000000),
                                fontSize: 14,
                                fontFamily: "Mukta_Vaani_Medium",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 6),
                      child: Container(
                        width: 71,
                        height: 105,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x3f000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'images/1984.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
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
                icon: const Icon(Icons.library_books),
                iconSize: 30,
                color: const Color.fromARGB(255, 6, 164, 61),
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
