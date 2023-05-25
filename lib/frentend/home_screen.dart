import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/frentend/login_screen.dart';
import '../backend/dbservices.dart';
import 'SearchPage.dart';
import 'categories_screen.dart';
import 'card_screen.dart';
import 'category_books_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';

import 'package:http/http.dart' as http;

import 'book_detail_screen.dart';
import 'book_list_screen.dart';

class HomePage extends StatefulWidget {
  static const String screenroute = 'home_screen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Livre> books = [];
  List<Categorie> categories = [];
  String token = '';

  TextEditingController searchController = TextEditingController();

  Categorie? selectedCategory;

  @override
  void initState() {
    super.initState();
    checkLoggedIn();
    fetchHomeBooks();
    fetchCategories();
  }

  Future<void> checkLoggedIn() async {
    final storedToken = await DBServices.getToken();
    setState(() {
      token = storedToken!;
    });
  }

  Future<void> fetchHomeBooks() async {
    final response =
        await http.get(Uri.parse('http://${Config.apiURL}${Config.bookAPI}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        books = data.map((json) => Livre.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to fetch books');
    }
  }

  Future<void> fetchCategories() async {
    final response = await http
        .get(Uri.parse('http://${Config.apiURL}${Config.categoryAPI}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        categories = data.map((json) => Categorie.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  void searchBooks(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(searchQuery: query),
      ),
    );
  }

  void navigateToCategoryPage(int categoryId, String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CategoryPage(categoryId: categoryId, categoryName: categoryName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Image.asset('images/background.jpg'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 70, 22, 0),
                  child: Material(
                    elevation: 20.0,
                    shadowColor: const Color.fromARGB(120, 0, 0, 0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by name, author...',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 183, 183, 183),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search_outlined),
                          onPressed: () => searchBooks(searchController.text),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(85, 0, 0, 0),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(171, 4, 126, 47),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 150, 0, 0),
                  child: Container(
                    width: 380,
                    height: 320,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(0),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            'New Collection',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 270,
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                            scrollDirection: Axis.horizontal,
                            itemCount: books.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              width: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                SizedBox(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 190,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Material(
                                          child: Ink.image(
                                            height: 150,
                                            width: 130,
                                            image: AssetImage(
                                                "images${books[index].PAGE_DE_GARDE}"),
                                            fit: BoxFit.cover,
                                            child: InkWell(
                                              onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Book_Detail(
                                                          book: books[index]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                  const SizedBox(height: 2),
                                  Text(
                                    books[index].TITRE,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      fontFamily: "PoppinsBold",
                                    ),
                                  ),
                                  Text(
                                    books[index].AUTHEUR,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: "Poppins_Reguler",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "PoppinsBold",
                        ),
                      ),
                      const SizedBox(width: 190),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See All',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins_Reguler",
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 500,
                  height: 55,
                  child: CategoryList(
                    categories: categories,
                    onTap: (categoryId, categoryName) =>
                        navigateToCategoryPage(categoryId, categoryName),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 290, 0),
              child: Text(
                'Trending',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PoppinsBold",
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
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
              child: gridList(),
            ),
          ],
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
        itemCount: books.length,
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
                      image: AssetImage("images${books[index].PAGE_DE_GARDE}"),
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Book_Detail(book: books[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
                const SizedBox(height: 4),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<Categorie> categories;
  final Function(int, String) onTap;

  CategoryList({required this.categories, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 9,
      ),
      itemBuilder: (_, index) => GestureDetector(
        onTap: () => onTap(categories[index].ID_CAT, categories[index].LIBELLE),
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              categories[index].LIBELLE,
              style: const TextStyle(
                color: Color(0xff06a33b),
                fontSize: 15,
                fontFamily: "PoppinsBold",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
