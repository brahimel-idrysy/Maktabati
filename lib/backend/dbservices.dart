import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DBServices {
  static const String tokenKey = '';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
}

class Config {
  static const String apiURL = '10.0.2.2:3000';
  static const String loginAPI = '/login';
  static const String registerAPI = '/register';
  static const String bookAPI = '/books';
  static const String categoryAPI = '/categories';
  static const String profileAPI = '/profile';
  static const String editprofileAPI = '/editprofile';
}

class Livre {
  final int ID_LIVRE;
  final String TITRE;
  final String AUTHEUR;
  final String OBSERVATION;
  final String PAGE_DE_GARDE;
  final String SOMAIRE;
  final int PRIX;
  final String EDITEUR;
  final int DATE_EDITION;
  final int CODE;

  Livre({
    required this.ID_LIVRE,
    required this.TITRE,
    required this.AUTHEUR,
    required this.OBSERVATION,
    required this.PAGE_DE_GARDE,
    required this.SOMAIRE,
    required this.PRIX,
    required this.CODE,
    required this.EDITEUR,
    required this.DATE_EDITION,
  });

  factory Livre.fromJson(Map<String, dynamic> json) {
    return Livre(
      ID_LIVRE: json['ID_LIVRE'],
      TITRE: json['TITRE'],
      AUTHEUR: json['AUTHEUR'],
      OBSERVATION: json['OBSERVATIONL'],
      CODE: json['CODE'],
      PAGE_DE_GARDE: json['PAGE_DE_GARDE'],
      PRIX: json['PRIX'],
      SOMAIRE: json['SOMAIRE'],
      DATE_EDITION: json['DATE_EDITION'],
      EDITEUR: json['EDITEUR'],
    );
  }
}

class Categorie {
  final int ID_CAT;
  final String LIBELLE;

  Categorie({
    required this.ID_CAT,
    required this.LIBELLE,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      ID_CAT: json['ID_CAT'],
      LIBELLE: json['LIBELLE'],
    );
  }
}
