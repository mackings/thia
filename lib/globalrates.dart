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

  late Map Power;

  get Release => null;

  fetchapi() async {
    final Response = await http.get(Uri.parse(url)).then((response) {
      final Datas = Map<String, dynamic>.from(json.decode(response.body));

      print(Datas);
      setState(() {
        Power = Datas;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchapi();
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
                    fetchapi();
                  },
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FutureBuilder(
                      future: fetchapi(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return  Text(
                            "1 BTC = ${Power['USD']['buy']} USD",
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
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
