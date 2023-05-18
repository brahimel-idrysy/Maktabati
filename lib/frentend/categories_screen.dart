import 'package:flutter/material.dart';

import 'book_list_screen.dart';
import 'card_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final List<String> category = <String>[
    'History',
    'Design',
    'Fantasy',
    'Science Fiction'
  ];
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 100, 100, 100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 300, top: 10),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(30, 0, 16, 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (BuildContext context, int index) => SizedBox(
                    height: 50,
                    child: Center(
                        child: Text(
                      category[index],
                      style: TextStyle(
                        color: Colors.green[colorCodes[index]],
                        fontFamily: "Mukta_Vaani_Medium",
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 25, 15, 20),
                width: 600,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Colors.white,
                ),
                child: gridList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 9,
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
    );
  }
}
