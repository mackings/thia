import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thiago_exchange/Sellbtc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:thiago_exchange/tradeground.dart';
import 'package:http/http.dart' as http;

class finalbuy extends StatefulWidget {
  const finalbuy({Key? key}) : super(key: key);

  @override
  _finalbuyState createState() => _finalbuyState();
}

class _finalbuyState extends State<finalbuy> {
  TextEditingController _cryptoname = TextEditingController();
  TextEditingController _walletemail = TextEditingController();
  TextEditingController _walletaddressController = TextEditingController();
  TextEditingController _phonenumber = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  final Database = FirebaseDatabase.instance.reference();

  var emailurl = "https://fapimail.p.rapidapi.com/email/send";

  String? get userid => null;

  Future Mailadmin() async {
    var response = await http.post(
      Uri.parse(emailurl),
      headers: {
       'x-rapidapi-host': 'fapimail.p.rapidapi.com',
    'x-rapidapi-key': '4d3203bd54mshae69b36a7cd471fp12e74fjsn565cea5d6fdd'
      },
      body: json.encode({
         "recipient": "kingsleyudoma2018@gmail.com",
    "sender": "macsonline500@gmail.com",
    "subject": "Subject of Email",
    "message": "Body of Email"
        
      }),
    );

    if (response.statusCode == 200) {
      print("Email sent");
    } else {
      print("Email not sent");
      print(response.statusCode);
    }
  }

  sendtrades() async {

    final FirebaseDatabase database = FirebaseDatabase.instance;
    //var userid = await FirebaseAuth.instance.currentUser();
   FirebaseFirestore.instance.collection('CRYPTO BUYERS').doc(userid).set({
      'CryptoName': _cryptoname.text.trim(),
      'email': _walletemail.text.trim(),
      'phonenumber': _phonenumber.text.trim(),
      'walletaddress': _walletaddressController.text.trim(),
      'status': 'Pending',
      'date': DateTime.now().toString()
      
    }).whenComplete(() => print("Sent Trade Requests"));
  }


   var emailapiurl = 'https://easymail.p.rapidapi.com/send';
  final usermail = FirebaseAuth.instance.currentUser!.email;

  dynamic result;
  Future mailgun() async {
    var response = await http.post(Uri.parse(emailapiurl),
        headers: {
          'content-type': 'application/json',
          'x-rapidapi-host': 'easymail.p.rapidapi.com',
          'x-rapidapi-key': '4d3203bd54mshae69b36a7cd471fp12e74fjsn565cea5d6fdd'
        },
        //body
        body: jsonEncode({
          "from": "Admin@Thiago exchange",
          "to": 'spacemars666@gmail.com',
          "subject": "Withdraw Request",
          "message":
              "<h1>${usermail} Has Requested to Buy ${_cryptoname.text} , Kindly Modify</h1>"

        }));

    if (response.statusCode == 200) {
      result = json.decode(response.body);
      print('Admin Notified Successfully');

      print(result);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    SvgPicture.asset(
                      "assets/eth.svg",
                      height: 250,
                      width: 250,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 70,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _cryptoname,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Enter Crypto Name",
                              hintStyle: GoogleFonts.montserrat(
                                color: Colors.deepPurpleAccent,
                              ),
                              suffixIcon: Icon(
                                Icons.assessment,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 7) {
                                return "Please Enter a valid crypto name";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _cryptoname.text = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 70,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _walletaddressController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Enter wallet Address",
                              hintStyle: GoogleFonts.montserrat(
                                color: Colors.deepPurpleAccent,
                              ),
                              suffixIcon: Icon(
                                Icons.maps_ugc_sharp,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty &&
                                      RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                                return "Please Enter a valid wallet Address";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _cryptoname.text = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 70,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _walletemail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Enter Wallet Email Address",
                              hintStyle: GoogleFonts.montserrat(
                                color: Colors.deepPurpleAccent,
                              ),
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter  a valid Wallet email";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _walletemail.text = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 70,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _phonenumber,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Enter Phone number",
                              hintStyle: GoogleFonts.montserrat(
                                color: Colors.deepPurpleAccent,
                              ),
                              suffixIcon: Icon(
                                Icons.phone,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter a valid PhoneNumber";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _phonenumber.text = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                "Confirm Trade ?",
                                style: GoogleFonts.montserrat(),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("YES",
                                      style: GoogleFonts.montserrat()),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      mailgun();
                                      sendtrades();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Success",
                                              style: GoogleFonts.montserrat(),
                                            ),
                                            content: Text(
                                              "Your Trade has been Submitted, You would be contacted soon",
                                              style: GoogleFonts.montserrat(),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Continue",
                                                    style:
                                                        GoogleFonts.montserrat()),
                                                onPressed: () {
                                                  //sendtrades();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TradeGround()));
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("Home",
                                                    style:
                                                        GoogleFonts.montserrat()),
                                                onPressed: () {
                                                  sendtrades();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TradeGround()));
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                     // sendtrades();
                                    } else {
                                      print("Invaid");
                                    }
                                  },
                                ),
                                FlatButton(
                                  child:
                                      Text("NO", style: GoogleFonts.montserrat()),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 280,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Buy Now ",
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            )),
                          ),
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
    );
  }
}
