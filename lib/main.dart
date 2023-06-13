import 'package:flutter/material.dart';
import 'frentend/book_list_screen.dart';
import 'frentend/card_screen.dart';
import 'frentend/categories_screen.dart';
import 'backend/dbservices.dart';
import 'frentend/favorite_screen.dart';
import 'frentend/home_screen.dart';
import 'frentend/login_screen.dart';
import 'frentend/splash_screen.dart';

import 'frentend/book_detail_screen.dart';
import 'frentend/editProfile_screen.dart';
import 'frentend/profile_screen.dart';
import 'frentend/registre_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: RegistrePage(),
      initialRoute: splashPage.screenroute,
      routes: {
        splashPage.screenroute: (context) => splashPage(),
        RegistrePage.screenroute: (context) => RegistrePage(),
        LoginPage.screenroute: (context) => LoginPage(),
        HomePage.screenroute: (context) => HomePage(),
        profilePage.screenroute: (context) => profilePage(),
        editProfile.screenroute: (context) => editProfile(),
        CategoriesPage.screenroute: (context) => CategoriesPage(),
        CardPage.screenroute: (context) => CardPage(),
        bookListPage.screenroute: (context) => bookListPage(),
        FavoritePage.screenroute: (context) => FavoritePage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        // Check if user is logged in and redirect accordingly
        String? authToken = DBServices.getToken() as String?;
        if (authToken != null) {
          switch (settings.name) {
            case LoginPage.screenroute:
            case RegistrePage.screenroute:
              // User is already logged in, redirect to home
              return MaterialPageRoute(builder: (context) => HomePage());
          }
        } else {
          switch (settings.name) {
            case HomePage.screenroute:
            case CategoriesPage.screenroute:
            case CardPage.screenroute:
            case bookListPage.screenroute:
              // User is not logged in, redirect to login
              return MaterialPageRoute(builder: (context) => LoginPage());
          }
        }
        return null;
      },
    );
  }
}
