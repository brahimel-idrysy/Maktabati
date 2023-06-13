import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path_provider/path_provider.dart';
import '../backend/dbservices.dart';
import 'PDFViewer.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import 'book_list_screen.dart';
import 'profile_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as pdfWidgets;

class CardPage extends StatefulWidget {
  static const String screenroute = 'card_screen';

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<Livre> card = [];
  String token = '';
  int? nApogee;
  String? nom;
  String? prenom;
  String selectedDate = '';
  Map<String, dynamic> decodedToken = {};
  @override
  void initState() {
    super.initState();
    _getToken();

    fetchfavorites();
  }

  void _getToken() async {
    final gettoken = await DBServices.getToken();
    setState(() {
      token = gettoken!;
    });
    decodedToken = JwtDecoder.decode(token);
    // Access the user information from the decoded token
    nApogee = decodedToken['n_apogee'];

    nom = decodedToken['nom'];
    prenom = decodedToken['prenom'];
  }

  Future<void> fetchfavorites() async {
    final response =
        await http.get(Uri.parse('http://${Config.apiURL}${Config.cardAPI}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        card = data.map((json) => Livre.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  Future<void> removefromcard(int bookid) async {
    // Create the request body
    final body = {'bookid': bookid, 'napogee': nApogee};

    // Make API call to removecard endpoint
    final response = await http.post(
      Uri.parse('http://${Config.apiURL}${Config.removecardAPI}'),
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
                      builder: (context) => CardPage(),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked.toString().substring(0, 10);
      });

      // Check if nApogee is not null or empty
      if (nApogee != null) {
        _submitReservation();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Invalid ID_E. Please provide a valid value.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _submitReservation() async {
    // Check if selectedDate and nApogee are not null or empty
    if (selectedDate != null && selectedDate.isNotEmpty && nApogee != null) {
      // Create the request body
      final body = {
        'recuperationDate': selectedDate,
        'ID_E': nApogee,
      };
      print('date:$selectedDate');
      print(nApogee);

      // Perform the reservation submission to the backend server
      final response = await http.post(
        Uri.parse('http://${Config.apiURL}${Config.reservationAPI}'),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Reservation successful, display a success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Reservation confirmed for $selectedDate'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () => fetchreservationData(),
                ),
              ],
            );
          },
        );
      } else {
        // Reservation failed, display an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to make a reservation. Please try again.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  List<Map<String, dynamic>> res_data = [];

  Future<void> fetchreservationData() async {
    final url = Uri.parse(
        'http://${Config.apiURL}${Config.reservationdataAPI}?nApogee=$nApogee&selectedDate=$selectedDate');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        res_data = jsonData.cast<Map<String, dynamic>>();
      });
      generatePDF();
    }
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    // Read the logo image as bytes
    final ByteData logoImageBytes_1 =
        await rootBundle.load('images/school_logo.png');

    // Add images
    final logoImage_1 = pw.MemoryImage(logoImageBytes_1.buffer.asUint8List());

    // Read the logo image as bytes
    final ByteData logoImageBytes_2 = await rootBundle.load('images/R.png');

    // Add images
    final logoImage_2 = pw.MemoryImage(logoImageBytes_2.buffer.asUint8List());

    // Add page
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(logoImage_1, width: 80, height: 80),
                    pw.Text(
                      'Reservation',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Image(logoImage_2, width: 80, height: 80),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Text(
                      'Nom :',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      '${nom!} ${prenom!}',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Text(
                      'N_Apogee :',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      '$nApogee',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Text(
                      'Reservation Code :',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      "${res_data[0]['RES_CODE']}",
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Text(
                      'Date de recuperation :',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      "${res_data[0]['DATE_DE_RECUPERATION']}",
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>['ID', 'TITRE'],
                    ...res_data
                        .map((item) => [item['ID'].toString(), item['TITRE']])
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    // Save the generated PDF to a file
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/reservation.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the generated PDF using a PDF viewer or navigate to a PDF viewer screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewer(file: file),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 240, top: 10),
                child: Text(
                  'Your Card',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: "Mukta_Vaani_Bold",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (card.isEmpty)
                const Text(
                  "You don't have any book yet",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontFamily: "Mukta_Vaani_Bold",
                    fontWeight: FontWeight.w400,
                  ),
                )
              else
                Stack(
                  children: [
                    Container(
                      width: 600,
                      height: 750,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 197),
                        child: SizedBox(
                          child: ListView.separated(
                            itemCount: card.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                SizedBox(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 40, 0),
                                child: SizedBox(
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        width: 380,
                                        height: 103,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              100, 20, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                card[index].TITRE,
                                                style: const TextStyle(
                                                  fontFamily:
                                                      "Mukta_Vaani_Bold",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                card[index].AUTHEUR,
                                                style: const TextStyle(
                                                  color: Color(0x8c000000),
                                                  fontSize: 14,
                                                  fontFamily:
                                                      "Mukta_Vaani_Medium",
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            95, 80, 0, 0),
                                        child: TextButton(
                                          onPressed: () => removefromcard(
                                              card[index].ID_LIVRE),
                                          child: const Text(
                                            "Remove",
                                            style: TextStyle(
                                              color: Color(0xdbff0000),
                                              fontSize: 16,
                                              fontFamily: "Mukta_Vaani_Medium",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 6),
                                        child: Container(
                                          width: 71,
                                          height: 105,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x3f000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Image.asset(
                                            "images${card[index].PAGE_DE_GARDE}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(110, 555, 110, 0),
                      child: Material(
                        elevation: 5,
                        color: const Color(0xff03c545),
                        borderRadius: BorderRadius.circular(20),
                        child: MaterialButton(
                          minWidth: 167,
                          height: 50,
                          onPressed:
                              card.isEmpty ? null : () => _selectDate(context),
                          child: const Text(
                            'Borrow Now',
                            style: TextStyle(
                              fontFamily: "PoppinsBold",
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                icon: const Icon(Icons.shopping_cart),
                iconSize: 30,
                color: const Color.fromARGB(255, 6, 164, 61),
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
