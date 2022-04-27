import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thiago_exchange/Sellbtc.dart';
import 'package:thiago_exchange/Userbalance.dart';
import 'package:thiago_exchange/adminpage.dart';
import 'package:thiago_exchange/buybtc.dart';
import 'package:thiago_exchange/games.dart';
import 'package:thiago_exchange/globalrates.dart';
import 'package:thiago_exchange/login.dart';
import 'package:thiago_exchange/finalbuy.dart';
import 'package:thiago_exchange/pass.dart';
import 'package:thiago_exchange/withdraws.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:carousel_slider/carousel_controller.dart";
import "package:crypt/crypt.dart";
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:selectable/selectable.dart';

class TradeGround extends StatefulWidget {
  const TradeGround({Key? key}) : super(key: key);

  @override
  _TradeGroundState createState() => _TradeGroundState();
}

class _TradeGroundState extends State<TradeGround> {
  //whatsapp
  var whatsapp =
      ("https://wa.me/2348167556757?text=Hello%20Thiago Exchange%2C%20%20 %20it was %20%20Nice using Your Mobile App");

  void _launchURL() async => await canLaunch(whatsapp)
      ? await launch(whatsapp)
      : throw 'Could not launch $whatsapp';

  //Remote server
  RemoteConfig remoteConfig = RemoteConfig.instance;

  Future Activate() async {
    bool updated = await remoteConfig.fetchAndActivate();
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 60),
      minimumFetchInterval: Duration(minutes: 5),
    ));
    if (updated) {
      print("Remote Config Updated");

      //actions

    } else {
      //reverseacions

    }
  }

  var walletID;
  dynamic Actualbal;

  Future viewhive() async {
    final balbox = Hive.box('user');
    print(balbox.get('walletBalance'));
    print(balbox.get('walletid'));
    setState(() {
      Actualbal = balbox.get('walletBalance');
      walletID = balbox.get('walletid');
    });
    print('Actualbalance is $Actualbal');
    print('walletID is $walletID');
  }

  getremotevalues() {}

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final CarouselController _controller = CarouselController();

  //Datadecrypt

  Future Createrwallet() async {}

  var useremail = FirebaseAuth.instance.currentUser!.email;

  getshareddata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('walletid');
    final value2 = prefs.getString('walletbalance');
    print(value);
    setState(() {
      walletID = value;
      Actualbal = value2;
    });

    print('prefs got $walletID');
    print('prefs got $Actualbal');
  }

  dynamic alldata;
  dynamic walletBalance;
  dynamic result;
  dynamic walletdata;
  var getbearer = 'sk_live_61d69f09ea5aa2f41200885961d69f09ea5aa2f41200885a';

  Future Fetchuserbalance() async {
    var balanceurl = ('https://api.getwallets.co/v1/wallets/$walletID');

    var response = await http.get(
      Uri.parse(balanceurl),
      headers: {
        "Content-Type": "application/json",
        //"Accept": "application/json",
        "Authorization": "Bearer $getbearer",
      },
    );

    if (response.statusCode == 200) {
      walletdata = json.decode(response.body);
      //print(walletdata["data"]['balances'][0]['balance']);

      setState(() {
        walletBalance = '${walletdata['data']['balances'][0]['balance']}';
      });

      // print('users balance is $walletBalance');
    } else {
      print(response.statusCode);
    }
  }

  dynamic prefsdefid;
  dynamic prefsdefbal;

  Fetchprefsdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var prefid = prefs.getString('walletid');
    var prefbal = prefs.getString('walletbalance');

    setState(() {
      prefsdefid = prefid;
      prefsdefbal = prefbal;
    });
    print('prefs is $prefid');
    print('prefs is $prefbal');
    print('prefs  state is $prefsdefid');
    print('prefs  state is $prefsdefbal');
  }

  Future getuserbalance() async {
    var balanceurl = ('https://api.getwallets.co/v1/wallets/${prefsdefid}');

    var response = await http.get(
      Uri.parse(balanceurl),
      headers: {
        "Content-Type": "application/json",
        //"Accept": "application/json",
        "Authorization": "Bearer $getbearer",
      },
    );

    if (response.statusCode == 200) {
      walletdata = json.decode(response.body);
      ////print(walletdata["data"]['balances'][0]['balance']);

      setState(() {
        walletBalance = '${walletdata['data']['balances'][0]['balance']}';
      });

      // print('user balances is $walletBalance');
    } else {
      print(response.statusCode);
    }
  }

  //dialogs

  iddialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Wallet ID',
              style: GoogleFonts.montserrat(fontSize: 20)),
          content: Selectable(
              child: Text('$walletID',
                  style: GoogleFonts.montserrat(fontSize: 20))),
          actions: <Widget>[
            MaterialButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    Fetchprefsdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      key: _globalKey,
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                ),
                child: Stack(children: <Widget>[
                  Positioned(
                      top: 62,
                      left: 48.3457260131836,
                      child: Row(
                        children: [
                          Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(81, 163, 163, 1),
                                  width: 1,
                                ),
                                image: DecorationImage(
                                    image: AssetImage('assets/bitcoin.png'),
                                    fit: BoxFit.fitWidth),
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(80, 80)),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => getuserbalance(),
                                child: Text(
                                  "N $walletBalance",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () => iddialog(),
                                child: Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  Positioned(
                      top: 168,
                      left: 55.345726013183594,
                      child: Row(
                        children: [
                          //textid
                          Icon(Icons.account_balance_wallet,
                              color: Colors.white, size: 30),

                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Globalrates()));
                            },
                            child: GestureDetector(
                              onTap: () {
                                Fetchuserbalance();
                              },
                              child: Text(
                                "View My ID",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 210,
                      left: 58.345726013183594,
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              iddialog();
                            },
                            child: Text(
                              "$useremail",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 257,
                      left: 58.345726013183594,
                      child: Row(
                        children: [
                          Icon(
                            Icons.web,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Globalrates()));
                            },
                            child: Text(
                              "Global Rates",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 200,
                      left: 58.345726013183594,
                      child: Row(
                        children: [
                          // Icon(
                          //  Icons.wallet_giftcard,
                          //  color: Colors.white,
                          // ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      )),
                  Positioned(
                      top: 298,
                      left: 58.345726013183594,
                      child: Row(
                        children: [
                          Icon(
                            Icons.help,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL();
                            },
                            child: Text(
                              "Help and Support",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Positioned(
                      top: 350,
                      left: 58.345726013183594,
                      child: Row(
                        children: [
                          Icon(
                            Icons.help,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Withdraws()));
                            },
                            child: Text(
                              "Withdraws",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 400,
                      left: 58.345726013183594,
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Pass()));
                            },
                            child: Text(
                              " Thiago Portal",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 487,
                      left: 55.345726013183594,
                      child: Container(
                          width: 156.1904754638672,
                          height: 50,
                          child: Stack(children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  child: Container(
                                      width: 150,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                          top: 11,
                                          left: 43,
                                          child: Text(
                                            "Logout ",
                                            style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )),
                                          ),
                                        ),
                                      ])),
                                )),
                          ]))),
                ]))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 0,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                            onTap: () {
                              getshareddata();
                              Fetchuserbalance();
                              Activate();
                              Fetchprefsdata();
                              _globalKey.currentState!.openDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 40,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),

              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2,
                  viewportFraction: 0.9,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                items: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/eth.jpg'),
                            fit: BoxFit.cover)),
                  ),

//image2
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/bitcoin.png'),
                            fit: BoxFit.cover)),
                  ),

                  //img3

                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/cry1.png'),
                            fit: BoxFit.cover)),
                  ),

                  //im4

                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/cry2.png'),
                            fit: BoxFit.cover)),
                  ),

                  //img5

                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/cry4.png'),
                            fit: BoxFit.cover)),
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/cry5.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ],
              ),

              // SvgPicture.asset(
              // "assets/girls.svg",
              ////height: MediaQuery.of(context).size.height - 430,
              // width: MediaQuery.of(context).size.width,
              //  ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width - 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "BITCOIN : ",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                          color: Colors.deepPurpleAccent,
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "               ${remoteConfig.getString("Bitcoins")}",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width - 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "USDT: ",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                          color: Colors.deepPurpleAccent,
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: MediaQuery.of(context).size.height / 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          "                     ${remoteConfig.getString("Usdt")}",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width - 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "ETHERIUM : ",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                          color: Colors.deepPurpleAccent,
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "             ${remoteConfig.getString("Etherium")}",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Activate();
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Buycoin()));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 12,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "Our Excange",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Createrwallet();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Sellbtc()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 12,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text(
                              "Yours",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                color: Colors.white,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
