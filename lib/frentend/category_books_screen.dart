import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../backend/dbservices.dart';
import 'book_detail_screen.dart';
import 'book_list_screen.dart';
import 'card_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class CategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  CategoryPage({required this.categoryId, required this.categoryName});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Livre> categoryBooks = [];

  @override
  void initState() {
    super.initState();
    fetchCategoryBooks();
  }

  Future<void> fetchCategoryBooks() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/books/category/${widget.categoryId}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        categoryBooks = data.map((json) => Livre.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to fetch category books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 200, top: 20),
                child: Text(
                  widget.categoryName,
                  style: const TextStyle(
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: gridList(),
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

  Widget gridList() {
    return SizedBox(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 170),
        itemCount: categoryBooks.length,
        itemBuilder: (_, index) {
          return SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    child: Material(
                      child: Ink.image(
                        height: 100,
                        image: AssetImage(
                            "images${categoryBooks[index].PAGE_DE_GARDE}"),
                        fit: BoxFit.cover,
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Book_Detail(book: categoryBooks[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
