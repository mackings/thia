// ignore: file_names
// ignore: file_names
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:image_picker/image_picker.dart';
import "package:firebase_storage/firebase_storage.dart";
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thiago_exchange/tradeground.dart';
import 'package:selectable/selectable.dart';
import 'package:http/http.dart' as http;

class Sellbtc extends StatefulWidget {
  const Sellbtc({Key? key}) : super(key: key);

  @override
  _SellbtcState createState() => _SellbtcState();
}

class _SellbtcState extends State<Sellbtc> {
  //proofupload
  File? _selectedImage;
  final picker = ImagePicker();

  late String imageLink;

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //Database

  // Uploadproof() async {
  //  FirebaseStorage fs = FirebaseStorage.instance;
  // final reference = fs.ref();
  //final picturefolder = reference.child("Proffs").child("Cards");
  // picturefolder.putFile(_selectedImage!).whenComplete(() => () async {
  //       imageLink = await picturefolder.getDownloadURL();
  //      print("Hellow");
  //    });
  //}

  UploadimagewithID() async {
    FirebaseStorage fs = FirebaseStorage.instance;
    final reference = fs.ref();
    final picturefolder = reference.child("Transaction Shots").child("Cards");
    UploadTask uploadTask = picturefolder.putFile(_selectedImage!);
    await uploadTask.then((p0) => p0.ref.getDownloadURL().then((p1) {
          imageLink = p1.toString();
          print(imageLink);
        }));
    picturefolder.putFile(_selectedImage!).whenComplete(() => () async {
          var imageLink = await picturefolder.getDownloadURL();
          print(imageLink);
        });
  }

  final Database = FirebaseDatabase.instance.reference();
  final User = FirebaseAuth.instance.currentUser;

  uploadseller() {
    FirebaseFirestore.instance.collection('CRYPTO SELLERS').doc(userId).set({
      'User Email': User!.email,
      'User ID': User!.uid,
      'status': 'Pending',
      'date': DateTime.now().toString(),
      'image': url,
    }).whenComplete(() => print("Sent Trade Requests"));
  }

  uploadTransimage() {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("Transaction Shots + " + userId + ".jpg")
        .child("Cards");
    UploadTask uploadTask = reference.putFile(_selectedImage!);
    uploadTask.then((result) async {
      String url = await reference.getDownloadURL();
      print("Uploaded $url");
    }).catchError((error) {
      print("Error");
    });
  }

  Future sendLatestsales() async {
    final sendtrade =
        await Database.child("Users").child(userId).child("LatestSales").set({
      "Image": imageLink,
      "Price": "Default",
      "Time": DateTime.now().toString(),
      "Type": "Sell",
      "UserID": userId,
    });
  }

  //Remote server
  RemoteConfig WALLETConfig = RemoteConfig.instance;

  Future waletconfig() async {
    bool updated = await WALLETConfig.fetchAndActivate();
    await WALLETConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 60),
      minimumFetchInterval: Duration(minutes: 1),
    ));
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
              "<h1>${usermail} Has Sent You a Cryptocurrency, Kindly Modify</h1>"
        }));

    if (response.statusCode == 200) {
      result = json.decode(response.body);
      print('Admin Notified Successfully');

      print(result);
    } else {
      print(response.statusCode);
    }
  }

  TextEditingController rates = TextEditingController();
  TextEditingController network = TextEditingController();

  calculaterates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var btcrate = WALLETConfig.getInt('btcrate');
    var ethrate = WALLETConfig.getInt('ethrate');
    var usdtrate = WALLETConfig.getInt('usdtrate');

    print(btcrate);
    print(ethrate);
    print(usdtrate);

    var finalrate = btcrate * double.parse(rates.text);
    print('Your Earnings is $finalrate');

    prefs.setDouble('btcrate', finalrate);
    var finaldata = prefs.getDouble('btcrate');
    print(finaldata);

    if (network.text == 'BTC') {
      var finalrate = btcrate * double.parse(rates.text);
      setState(() {
        dbtc = finalrate;
      });
    } else if (network.text == 'ETH') {
      var finalrate = ethrate * double.parse(rates.text);
      setState(() {
        dbtc = finalrate;
      });
    } else if (network.text == 'USDT') {
      var finalrate = usdtrate * double.parse(rates.text);

      setState(() {
        dbtc = finalrate;
      });
    }

    //setState(() {
    // dbtc = finaldata;
    // });
  }

  //var btcrate = WALLETConfig.getInt('btcrate');
  var dbtc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                "assets/buy.svg",
                height: 250,
                width: 250,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Selectable(
                                  child: Text(
                                      "${WALLETConfig.getString("BTCWALLET")}")),
                              actions: [
                                FlatButton(
                                  child: Text(
                                    "Ok",
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                      waletconfig();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "BTC Wallet ",
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Selectable(
                                  child: Center(
                                      child: Text(
                                          "${WALLETConfig.getString("Ethwallet")}"))),
                              actions: [
                                FlatButton(
                                  child: Text("ok"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                      waletconfig();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "ETH Wallet ",
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Selectable(
                                  child: Center(
                                      child: Text(
                                          "${WALLETConfig.getString("Usdtwallet")}"))),
                              actions: [
                                FlatButton(
                                  child: Text("ok"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });

                      //waletconfig();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "USDT Wallet ",
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      calculaterates().then((value) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Total Earnings",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  "Your Earnings is $dbtc" == null
                                      ? "Please Try Again"
                                      : " You would be Credited N$dbtc",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                actions: [
                                  FlatButton(
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            });
                      });
                      waletconfig();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "  Calculate",
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  //waletconfig();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width - 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: rates,
                        decoration: InputDecoration(
                          hintText: "Enter Amount",
                          hintStyle: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          )),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  //waletconfig();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width - 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: network,
                        decoration: InputDecoration(
                          hintText: "Enter Crypto Name [BTC,ETH,USDT]",
                          hintStyle: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          )),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: _selectedImage == null
                            ? InkWell(
                                onTap: () => getImage(),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.image,
                                    size: 70,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () => getImage(),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(_selectedImage!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Upload Screenshot ",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                  "Hello, Have You Uploaded your Transaction Screenshot ?",
                                  style: GoogleFonts.montserrat(),
                                ),
                                actions: [
                                  MaterialButton(
                                    onPressed: () {
                                      if (_selectedImage == null) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Text(
                                                  "Please upload your screenshot",
                                                  style: GoogleFonts
                                                      .montserrat(),
                                                ),
                                                actions: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      // sendLatestsales();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Ok",
                                                      style: GoogleFonts
                                                          .montserrat(),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      } else {
                                        //Uploadproof();
                                        uploadseller();
                                        // uploadTransimage();
                                        UploadimagewithID();
                                        sendLatestsales();
                                        mailgun();
                                      }
                                      //Uploadproof();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Success",
                                              style: GoogleFonts.montserrat(),
                                            ),
                                            content: Text(
                                              "Your Trade has been Submitted, You would be Credited after a Successful Review",
                                              style: GoogleFonts.montserrat(),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Continue",
                                                    style: GoogleFonts
                                                        .montserrat()),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TradeGround()));
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("Home",
                                                    style: GoogleFonts
                                                        .montserrat()),
                                                onPressed: () {
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TradeGround()));
                                    },
                                    child: Text(
                                      "YES",
                                      style: GoogleFonts.montserrat(),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "NO",
                                      style: GoogleFonts.montserrat(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width - 180,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Center(
                            child: Text(
                              "Finish Trade ",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              )),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
