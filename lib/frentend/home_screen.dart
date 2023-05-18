import 'dart:convert';

import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'card_screen.dart';
import 'profile_screen.dart';

import 'package:http/http.dart' as http;

import 'book_detail_screen.dart';
import 'book_list_screen.dart';
import 'favorite_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class CardItem {
  final String urlImage;
  final String title;
  final String subtitle;
  const CardItem({
    required this.urlImage,
    required this.title,
    required this.subtitle,
  });
}

class _HomePageState extends State<HomePage> {
  List<CardItem> items = [
    const CardItem(
      urlImage: "images/rich dad poor dad.png",
      title: "Rich Dad Poor Dad",
      subtitle: "Robert T.Kiyosaki",
    ),
    const CardItem(
      urlImage: "images/game.jpg",
      title: "A Game Of Thrones",
      subtitle: "George R.R.Martin",
    ),
    const CardItem(
      urlImage: "images/first day.jpg",
      title: "The First Days",
      subtitle: "Rhiannon Frater",
    ),
    const CardItem(
      urlImage: "images/les miserables.jpg",
      title: "Les Miserables",
      subtitle: "Victor Hugo",
    ),
    const CardItem(
      urlImage: "images/1984.jpg",
      title: "1984",
      subtitle: "George Orwell",
    ),
  ];

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
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        hintText: 'Search by name, author...',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 183, 183, 183),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
                        prefixIcon: Icon(Icons.search_outlined),
                        suffixIcon: Icon(Icons.mic_outlined),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(85, 0, 0, 0),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
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
                    height: 330,
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
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'New Collection',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 290,
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                            scrollDirection: Axis.horizontal,
                            itemCount: items.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              width: 9,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                buildCard(item: items[index]),
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
                      const SizedBox(width: 220),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriesPage(),
                          ),
                        ),
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
                  height: 90,
                  child: category(),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 300, 0),
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

  Widget buildCard({required CardItem item}) => SizedBox(
        width: 120,
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
                      image: AssetImage(item.urlImage),
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Book_Detail(item: item))),
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 2),
            Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                fontFamily: "PoppinsBold",
              ),
            ),
            Text(
              item.subtitle,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 12,
                fontFamily: "Poppins_Reguler",
              ),
            ),
          ],
        ),
      );
}

class gridList extends StatefulWidget {
  @override
  State<gridList> createState() => _gridListState();
}

List<Map<String, dynamic>> data = [
  {"image": "images/game.jpg", "title": "A Game Of Thrones"},
  {"image": "images/game.jpg", "title": "A Game Of Thrones"},
  {"image": "images/game.jpg", "title": "A Game Of Thrones"},
  {"image": "images/game.jpg", "title": "A Game Of Thrones"},
  {"image": "images/game.jpg", "title": "A Game Of Thrones"},
  {"image": "images/game.jpg", "title": "A Game Of Thrones"},
  {"image": "images/game.jpg", "title": "A Game Of Thrones"},
  {"image": "images/game.jpg", "title": "A Game Of Thrones"},
  {"image": "images/game.jpg", "title": "A Game Of Thrones"},
  {"image": "images/game.jpg", "title": "A Game Of Thrones"},
  {"image": "images/game.jpg", "title": "A Game Of Thrones"}
];

class _gridListState extends State<gridList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 200),
      itemCount: data.length,
      itemBuilder: (_, index) {
        return SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ClipRRect(
                child: Image.asset(
                  data.elementAt(index)['image'],
                  fit: BoxFit.cover,
                ),
              )),
              const SizedBox(height: 4),
              Text(
                data.elementAt(index)['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class category extends StatefulWidget {
  @override
  State<category> createState() => _categoryState();
}

List<Map<String, dynamic>> cat = [
  {"image": "History", "title": "History"},
  {"image": "History", "title": "History"},
  {"image": "History", "title": "History"},
  {"image": "History", "title": "History"},
  {"image": "History", "title": "History"},
  {"image": "History", "title": "History"}
];

class _categoryState extends State<category> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      scrollDirection: Axis.horizontal,
      itemCount: cat.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 9,
      ),
      itemBuilder: (_, index) => Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        width: 95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const Icon(
              Icons.history_edu,
              color: Color(0xff06a33b),
              size: 30,
            ),
            Text(
              cat.elementAt(index)['image'],
              style: const TextStyle(
                color: Color(0xff06a33b),
                fontSize: 16,
              ),
            ),
            const Text(
              "52 books",
              style: TextStyle(
                color: Color(0xff06a43c),
                fontSize: 10,
                fontFamily: "Poppins_Reguler",
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
