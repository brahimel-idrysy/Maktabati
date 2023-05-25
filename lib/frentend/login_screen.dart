import 'dart:convert';
import 'dart:ui';
import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:gradients/gradients.dart';

import '../backend/dbservices.dart';
import 'home_screen.dart';
import 'registre_screen.dart';

class LoginPage extends StatefulWidget {
  static const String screenroute = 'login_screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final login = _loginController.text;
    final password = _passwordController.text;

    // Validate if login and password are not empty
    if (login.isEmpty || password.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Please enter login and password';
      });
      return;
    }

    // Encrypt the password using SHA-256
    // final encryptedPassword = sha256.convert(utf8.encode(password)).toString();

    // Create the request body
    final body = {'login': login, 'password': password};

    // Make API call to login endpoint
    final response = await http.post(
      Uri.parse('http://${Config.apiURL}${Config.loginAPI}'),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Login successful
      // Extract the token from the response
      final token = json.decode(response.body)['token'];

      // Save the token securely using shared preferences
      //  use the 'dbservices' to store the token.
      await DBServices.saveToken(token);

      // Redirect user to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Login failed
      setState(() {
        _isLoading = false;
        _errorMessage = 'Invalid login or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 285, 0, 0),
                    child: SvgPicture.asset(
                      'images/Vector 1.svg',
                      height: 600,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
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
                        const Center(
                          child: Text(
                            'Welcome Back!',
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 81, 32),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'Login (votre Nom*)',
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
                            controller: _loginController,
                            decoration: const InputDecoration(
                                hintText: 'login',
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
                            'Password (votre N°apogee*)',
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
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: 'Password',
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
                        const SizedBox(height: 2),
                        if (_errorMessage.isNotEmpty)
                          Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(260, 0, 0, 0),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(143, 7, 81, 32),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(110, 8, 110, 8),
                          child: Material(
                            elevation: 5,
                            color: const Color.fromARGB(255, 6, 164, 61),
                            borderRadius: BorderRadius.circular(20),
                            child: MaterialButton(
                              onPressed: _isLoading ? null : login,
                              minWidth: 167,
                              height: 51,
                              child: _isLoading
                                  ? CircularProgressIndicator()
                                  : const Text(
                                      'Log in',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 130),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have account ?",
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
                                    builder: (context) => RegistrePage(),
                                  ),
                                ),
                                child: const Text(
                                  'Sign up',
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
