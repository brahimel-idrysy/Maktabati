import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/frentend/card_screen.dart';
import 'package:flutter_application_1/frentend/profile_screen.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../backend/dbservices.dart';
import 'book_list_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';

class Book_Detail extends StatefulWidget {
  static const String screenroute = 'bookdetail_screen';
  final Livre book;
  Book_Detail({required this.book});

  @override
  State<Book_Detail> createState() => _Book_DetailState();
}

class _Book_DetailState extends State<Book_Detail> {
  String token = '';
  int? nApogee;
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
  }

  Future<void> addtofavorite(
      int bookid,
      String titre,
      String author,
      String observation,
      String pagedegarde,
      String sommaire,
      int prix,
      String editeur,
      int date_edition,
      int code) async {
    // Create the request body
    final body = {
      'bookid': bookid,
      'napogee': nApogee,
      'titre': titre,
      'author': author,
      'observation': observation,
      'pagedegarde': pagedegarde,
      'sommaire': sommaire,
      'prix': prix,
      'editeur': editeur,
      'date_edition': date_edition,
      'code': code
    };

    final response = await http.post(
      Uri.parse('http://${Config.apiURL}${Config.addfavorieAPI}'),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritePage(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> addtocard(
      int bookid,
      String titre,
      String author,
      String observation,
      String pagedegarde,
      String sommaire,
      int prix,
      String editeur,
      int date_edition,
      int code) async {
    // Create the request body
    final body = {
      'bookid': bookid,
      'napogee': nApogee,
      'titre': titre,
      'author': author,
      'observation': observation,
      'pagedegarde': pagedegarde,
      'sommaire': sommaire,
      'prix': prix,
      'editeur': editeur,
      'date_edition': date_edition,
      'code': code
    };

    final response = await http.post(
      Uri.parse('http://${Config.apiURL}${Config.addtocardAPI}'),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CardPage(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

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
                            widget.book.AUTHEUR,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color.fromARGB(155, 110, 110, 110),
                              fontSize: 14,
                              fontFamily: "Mukta_Vaani_Light",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.book.TITRE,
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
                                  width: 90,
                                  height: 40,
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
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 0, 4, 0),
                                    child: TextButton(
                                      child: const Text(
                                        "Borrow Now",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: "Mukta_Vaani_Bold",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () => addtocard(
                                          widget.book.ID_LIVRE,
                                          widget.book.TITRE,
                                          widget.book.AUTHEUR,
                                          widget.book.OBSERVATION,
                                          widget.book.PAGE_DE_GARDE,
                                          widget.book.SOMAIRE,
                                          widget.book.PRIX,
                                          widget.book.EDITEUR,
                                          widget.book.DATE_EDITION,
                                          widget.book.CODE),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 28,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xfff4e9e9),
                                  ),
                                  child: IconButton(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 3, 10, 10),
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    onPressed: () => addtofavorite(
                                        widget.book.ID_LIVRE,
                                        widget.book.TITRE,
                                        widget.book.AUTHEUR,
                                        widget.book.OBSERVATION,
                                        widget.book.PAGE_DE_GARDE,
                                        widget.book.SOMAIRE,
                                        widget.book.PRIX,
                                        widget.book.EDITEUR,
                                        widget.book.DATE_EDITION,
                                        widget.book.CODE),
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
                              padding: const EdgeInsets.only(left: 16),
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
                                        "${widget.book.PRIX}",
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
                                        widget.book.EDITEUR,
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
                                        "${widget.book.DATE_EDITION}",
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
                                        "${widget.book.CODE}",
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
                                      "images${widget.book.PAGE_DE_GARDE}",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "images${widget.book.SOMAIRE}",
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
                              widget.book.OBSERVATION,
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
                        child:
                            Image.asset("images${widget.book.PAGE_DE_GARDE}"),
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
