import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../backend/dbservices.dart';
import 'book_detail_screen.dart';
import 'card_screen.dart';
import 'favorite_screen.dart';
import 'package:http/http.dart' as http;
import 'home_screen.dart';
import 'profile_screen.dart';

class bookListPage extends StatefulWidget {
  static const String screenroute = 'booklist_screen';
  @override
  State<bookListPage> createState() => _bookListPageState();
}

class _bookListPageState extends State<bookListPage> {
  List<BorrowedBook> borrowedBooks = [];
  String token = '';
  String? n_inscription;
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
    n_inscription = decodedToken['n_inscription'];
    fetchBorrowedBooks();
  }

  Future<void> fetchBorrowedBooks() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://${Config.apiURL}${Config.borrowbooksAPI}?n_inscription=${n_inscription}',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          borrowedBooks =
              data.map((json) => BorrowedBook.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to fetch books');
      }
    } catch (error) {
      print('Error fetching borrowed books: $error');
    }
  }

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
              if (borrowedBooks.isEmpty)
                const Text(
                  "You don't have any borrow book yet",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontFamily: "Mukta_Vaani_Bold",
                    fontWeight: FontWeight.w400,
                  ),
                )
              else
                SizedBox(
                  height: 800,
                  child: ListView.separated(
                    itemCount: borrowedBooks.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) => SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 380,
                              height: 103,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: (borrowedBooks[index].dateL <= 0)
                                    ? Colors.red
                                    : const Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(100, 20, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      borrowedBooks[index].titre,
                                      style: const TextStyle(
                                        fontFamily: "Mukta_Vaani_Bold",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      borrowedBooks[index].auteur,
                                      style: const TextStyle(
                                        color: Color(0x8c000000),
                                        fontSize: 14,
                                        fontFamily: "Mukta_Vaani_Medium",
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      "${borrowedBooks[index].dateL} Days Left",
                                      style: const TextStyle(
                                        color: Color(0x8c000000),
                                        fontSize: 14,
                                        fontFamily: "Mukta_Vaani_Medium",
                                        fontWeight: FontWeight.w700,
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
                                      "images${borrowedBooks[index].pageDeGarde}")),
                            )
                          ],
                        ),
                      ),
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
