import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:gradients/gradients.dart';

import '../backend/dbservices.dart';
import 'login_screen.dart';

class RegistrePage extends StatefulWidget {
  static const String screenroute = 'registre_screen';
  @override
  _RegistrePageState createState() => _RegistrePageState();
}

class _RegistrePageState extends State<RegistrePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _apogeeController = TextEditingController();
  final TextEditingController _feliereController = TextEditingController();
  final TextEditingController _numInscriptionsController =
      TextEditingController();

  Future<void> _register() async {
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final String primaryId = _apogeeController.text;
    final String feliere = _feliereController.text;
    final String numInscriptions = _numInscriptionsController.text;

    // Create the request body
    final body = {
      'firstName': firstName,
      'lastName': lastName,
      'primaryId': primaryId,
      'numInscriptions': numInscriptions,
      'feliere': feliere,
    };
    final response = await http.post(
      Uri.parse('http://${Config.apiURL}${Config.registerAPI}'),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Registration successful, redirect to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } else {
      // Registration failed, show an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Registration Failed'),
            content: Text('An error occurred during registration.'),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  'images/logo_green.svg',
                  height: 69,
                  width: 85,
                ),
                const SizedBox(height: 50),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        'Prenom',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 7, 81, 32),
                        ),
                      ),
                    ),
                    SizedBox(width: 100),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        'Nom',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 7, 81, 32),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        width: 170,
                        child: TextField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                              hintText: 'Prenom',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 183, 183, 183),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                              ),
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
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        width: 170,
                        child: TextField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                              hintText: 'Nom',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 183, 183, 183),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                              ),
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
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'N_Apogee',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 7, 81, 32),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _apogeeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'N_Apogee',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 183, 183, 183),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
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
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'Filere',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 7, 81, 32),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _feliereController,
                    decoration: const InputDecoration(
                        hintText: 'Filere',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 183, 183, 183),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
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
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'N_Inscription',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 7, 81, 32),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _numInscriptionsController,
                    decoration: const InputDecoration(
                        hintText: 'N_Inscription',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 183, 183, 183),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
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
                        )),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(110, 8, 110, 8),
                  child: Material(
                    elevation: 5,
                    color: const Color.fromARGB(255, 6, 164, 61),
                    borderRadius: BorderRadius.circular(20),
                    child: MaterialButton(
                      onPressed: _register,
                      minWidth: 167,
                      height: 51,
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have account ?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(143, 7, 81, 32),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        ),
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 7, 81, 32),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
