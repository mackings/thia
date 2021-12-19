import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hive/hive.dart';
import 'package:thiago_exchange/Sellbtc.dart';
import 'package:thiago_exchange/Userbalance.dart';
import 'package:thiago_exchange/adminpage.dart';
import 'package:thiago_exchange/buybtc.dart';
import 'package:thiago_exchange/games.dart';
import 'package:thiago_exchange/globalrates.dart';
import 'package:thiago_exchange/login.dart';
import 'package:thiago_exchange/finalbuy.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:carousel_slider/carousel_controller.dart";

class TradeGround extends StatefulWidget {
  const TradeGround({Key? key}) : super(key: key);

  @override
  _TradeGroundState createState() => _TradeGroundState();
}

class _TradeGroundState extends State<TradeGround> {
  //whatsapp
  var whatsapp =
      ("https://wa.me/2348167556757?text=Hello%20Thiago Exchange%2C%20%20 %20in%20%20Nice using Your Mobile App");
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        key: _globalKey,
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                  width: 231,
                  height: 812,
                  decoration: const BoxDecoration(
                    color: Colors.deepPurpleAccent,
                  ),
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 72,
                        left: 38.3457260131836,
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
                                SizedBox( width: 20,),

                                 Column(
                                   children: [

                                     Text(
                        "Wallet ID",
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            
                            color: Colors.white
                            ),
                      ),

                               Text(
                        "000000000",
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            
                            color: Colors.white
                            ),
                      ),
                                   ],
                                 ),
                          ],
                        )),
                    Positioned(
                        top: 237,
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
                                        builder: (context) => const Globalrates()));
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
                            Icon(
                              Icons.wallet_giftcard,
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
                                        builder: (context) => const Userbalance()));
                              },
                              child: Text(
                                "Wallet",
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
                        top: 272,
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
                    Positioned(
                        top: 310,
                        left: 58.345726013183594,
                        child: Row(
                          children: [
                            Icon(
                              Icons.gamepad,
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
                                        builder: (context) => Games()));
                              },
                              child: Text(
                                "Play Games",
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
                        top: 350,
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
                                        builder: (context) => Admin()));
                              },
                              child: Text(
                                "Admin",
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
                        top: 447,
                        left: 40.345726013183594,
                        child: Container(
                            width: 156.1904754638672,
                            height: 60,
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
                                        width: 156.1904754638672,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromRGBO(13, 14, 14, 1),
                                        ),
                                        child: Stack(children: <Widget>[
                                          Positioned(
                                            top: 11,
                                            left: 43,
                                            child: Text(
                                              "Logout ",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                color: Colors.white,
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
                  height: 20,
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
                                Activate();
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
                  height: 20,
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
                                  "Buy",
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
                                "Sell",
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
      ),
    );
  }
}
