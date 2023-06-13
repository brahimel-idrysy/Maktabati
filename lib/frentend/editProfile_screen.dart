import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/frentend/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../backend/dbservices.dart';

class editProfile extends StatefulWidget {
  static const String screenroute = 'editprofile_screen';
  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _ninscriptionController = TextEditingController();
  TextEditingController _feliereController = TextEditingController();

  bool isLoading = false;
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
    print("$nApogee");
    print('$token');

    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    // Create the request body
    print("$nApogee");
    final body = {'napogee': nApogee};

    // Make API call to login endpoint
    final response = await http.post(
      Uri.parse('http://${Config.apiURL}${Config.profileAPI}'),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _nomController.text = data['data']['nom'];
      _prenomController.text = data['data']['prenom'];
      _ninscriptionController.text = data['data']['n_inscription'];
      _feliereController.text = data['data']['filiere'];
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to fetch profile data.'),
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

  Future<void> saveProfileChanges() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.put(
      Uri.parse('http://${Config.apiURL}${Config.editprofileAPI}'),
      headers: {
        'Authorization': 'Bearer $nApogee',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'nom': _nomController.text,
        'prenom': _prenomController.text,
        'n_inscription': _ninscriptionController.text,
        'feliere': _feliereController.text,
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Profile changes saved successfully.'),
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
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to save profile changes.'),
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
              Row(
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(20, 10, 0, 0)),
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profilePage(),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const SizedBox(width: 250),
                  TextButton(
                    onPressed: isLoading ? null : saveProfileChanges,
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(183, 22, 169, 71),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Stack(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('images/user.png'),
                    radius: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 70, 0, 0),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(153, 6, 255, 89),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 280, 0),
                child: Text(
                  'Nom',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: TextField(
                  controller: _nomController,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Mukta Vaani",
                        fontWeight: FontWeight.w800,
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
                          color: Colors.transparent,
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
                padding: EdgeInsets.fromLTRB(0, 0, 270, 0),
                child: Text(
                  'Prenom',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: TextField(
                  controller: _prenomController,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Mukta Vaani",
                        fontWeight: FontWeight.w800,
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
                          color: Colors.transparent,
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
                padding: EdgeInsets.fromLTRB(0, 0, 230, 0),
                child: Text(
                  'N_inscription',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: TextField(
                  controller: _ninscriptionController,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Mukta Vaani",
                        fontWeight: FontWeight.w800,
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
                          color: Colors.transparent,
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
                padding: EdgeInsets.fromLTRB(0, 0, 290, 0),
                child: Text(
                  'Filiere',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: TextField(
                  controller: _feliereController,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Mukta Vaani",
                        fontWeight: FontWeight.w800,
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
                          color: Colors.transparent,
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
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
