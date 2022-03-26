import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:thiago_exchange/Sellbtc.dart';
import 'package:thiago_exchange/login.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:http/http.dart' as http;
import 'package:thiago_exchange/tradeground.dart';

class Globalrates extends StatefulWidget {
  const Globalrates({Key? key}) : super(key: key);

  @override
  _GlobalratesState createState() => _GlobalratesState();
}

class _GlobalratesState extends State<Globalrates> {
  final url = ("https://blockchain.info/ticker");
  final globalurl =
      ("https://api.coinstats.app/public/v1/coins?skip=0&limit=10");

  dynamic dataset;
  dynamic ethset;

  Future Getrate() async {
    var response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      print(data);
      setState(() {
        dataset = '${data['USD']['buy']}';
        //print(dataset.toString());
      });
    } else {
      print(response.statusCode);
    }
  }

  Future Geteth() async {
    var response = await http.get(Uri.parse(globalurl));
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      // print(data);

      setState(() {
        ethset = '${data['coins']}';
        print(ethset.toString());
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    //var fetchrates = Fetchrates();
    Getrate();
    Geteth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 90),
            Text("Global Rates ",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold))),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                    "Global Rates are simply the general figures which are used to calculate the exchange rate of any currency to USD",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
              ),
            ),
            SizedBox(height: 40),
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
                          'Buy BTC: ',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.deepPurpleAccent,
                          ),
                          child: Center(
                            child: Text(
                              dataset == null ? 'Loading...' : '$dataset USD',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  height: 100,
                  width: MediaQuery.of(context).size.width - 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
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
                          'Sell BTC: ',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              dataset == null ? 'Loading...' : '$dataset USD',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  height: 100,
                  width: MediaQuery.of(context).size.width - 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TradeGround()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height - 630,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  "Trade with Thiago",
                  style:
                      GoogleFonts.montserrat(fontSize: 20, color: Colors.black),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
