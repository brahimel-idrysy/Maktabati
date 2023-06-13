import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../backend/dbservices.dart';
import 'book_detail_screen.dart';
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
  List<Livre> favorites = [];
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
    fetchfavorites();
  }

  Future<void> fetchfavorites() async {
    print(nApogee);
    final response = await http.get(Uri.parse(
        'http://${Config.apiURL}${Config.favoriteAPI}?nApogee=$nApogee'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        favorites = data.map((json) => Livre.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  Future<void> removefavorite(int bookid) async {
    // Create the request body
    final body = {'bookid': bookid, 'napogee': nApogee};

    // Make API call to login endpoint
    final response = await http.post(
      Uri.parse('http://${Config.apiURL}${Config.removefavoriteAPI}'),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: Text('Book removed from your favorites.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritePage(),
                    ),
                  );
                },
                child: Text('OK'),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Please try again Later.'),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 210),
                  child: SizedBox(
                    height: 300,
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                      itemCount: favorites.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 20,
                      ),
                      itemBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 40, 0),
                          child: SizedBox(
                            child: Stack(
                              children: [
                                SizedBox(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Material(
                                      child: Ink.image(
                                        height: 170,
                                        width: 120,
                                        image: AssetImage(
                                            "images${favorites[index].PAGE_DE_GARDE}"),
                                        fit: BoxFit.cover,
                                        child: InkWell(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Book_Detail(
                                                  book: favorites[index]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(140, 10, 0, 0),
                                  child: Text(
                                    favorites[index].TITRE,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: "PoppinsBold",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          140, 40, 0, 0),
                                      child: Text(
                                        favorites[index].AUTHEUR,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: "Poppins_Reguler",
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 40, 0, 0),
                                      child: IconButton(
                                        icon: const Icon(Icons.favorite,
                                            color: Color(0xdbff0000)),
                                        onPressed: () => removefavorite(
                                            favorites[index].ID_LIVRE),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
