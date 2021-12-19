import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:thiago_exchange/login.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:http/http.dart' as http;

class Globalrates extends StatefulWidget {
  const Globalrates({Key? key}) : super(key: key);

  @override
  _GlobalratesState createState() => _GlobalratesState();
}

class _GlobalratesState extends State<Globalrates> {
  final url = ("https://blockchain.info/ticker");

  dynamic dataset;

  Future Getrate() async {
    var response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      print(data);
      setState(() {
        dataset = '${data['USD']['buy']}';
        print(dataset.toString());
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    //var fetchrates = Fetchrates();
    Getrate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 200),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Getrate();
                  },
                  child: Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '1 BTC = ',
                            style: GoogleFonts.montserrat(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            dataset == null ? 'Loading...' : '$dataset USD',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    height: 100,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              
            ],
          ),
        ),
      ),
    );
  }
}
