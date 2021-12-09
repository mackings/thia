// ignore: file_names
// ignore: file_names
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:image_picker/image_picker.dart';
import "package:firebase_storage/firebase_storage.dart";
import 'package:thiago_exchange/tradeground.dart';

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

  Uploadproof() async {
    FirebaseStorage fs = FirebaseStorage.instance;
    final reference = fs.ref();
    final picturefolder = reference.child("Proffs").child("Cards");
    picturefolder.putFile(_selectedImage!).whenComplete(() => () async {
          imageLink = await picturefolder.getDownloadURL();
          print("Hellow");
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SvgPicture.asset(
                  "assets/btc.svg",
                  height: 250,
                  width: 250,
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    waletconfig();
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "BTC Wallet ",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "${WALLETConfig.getString("BTCWALLET")}",
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                )),
                              ),
                            ),
                          ],
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
                    waletconfig();
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Eth Wallet",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${WALLETConfig.getString("Ethwallet")}",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              )),
                            ),
                          ],
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
                    waletconfig();
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Usdt Wallet ",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${WALLETConfig.getString("Usdtwallet")}",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
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
                                    "Have you screenshot your transaction ?",
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
                                          Uploadproof();
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
                                                "Your Trade has been Submitted, You would be contacted soon",
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
      ),
    );
  }
}
