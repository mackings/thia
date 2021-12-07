import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:thiago_exchange/Sellbtc.dart';
import 'package:thiago_exchange/buybtc.dart';
import 'package:thiago_exchange/games.dart';
import 'package:thiago_exchange/globalrates.dart';
import 'package:thiago_exchange/login.dart';
import 'package:thiago_exchange/finalbuy.dart';
import 'package:url_launcher/url_launcher.dart';


class TradeGround extends StatefulWidget {
  const TradeGround({Key? key}) : super(key: key);

  @override
  _TradeGroundState createState() => _TradeGroundState();
}

class _TradeGroundState extends State<TradeGround> {

  //whatsapp
  var whatsapp = ("https://wa.me/2348167556757?text=Hello%20Thiago Exchange%2C%20%20 %20in%20%20Nice using Your Mobile App");
  void _launchURL() async =>
      await canLaunch(whatsapp) ? await launch(whatsapp) : throw 'Could not launch $whatsapp';

  //Remote server
  RemoteConfig remoteConfig = RemoteConfig.instance;
  Future Activate() async{
    bool updated = await remoteConfig.fetchAndActivate();
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration( seconds: 60), minimumFetchInterval: Duration(minutes: 5),
    ));
    if(updated){
      print("Remote Config Updated");

      //actions

    }else{
      //reverseacions

    }

  }

  final GlobalKey<ScaffoldState> _globalKey= GlobalKey<ScaffoldState>();

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
                    color : Colors.deepPurpleAccent,
                  ),
                  child: Stack(
                      children: <Widget>[
                        Positioned(
                            top: 72,
                            left: 78.3457260131836,
                            child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  border : Border.all(
                                    color: Color.fromRGBO(81, 163, 163, 1),
                                    width: 1,
                                  ),
                                  image : DecorationImage(
                                      image: AssetImage('assets/bitcoin.png'),
                                      fit: BoxFit.fitWidth
                                  ),
                                  borderRadius : BorderRadius.all(Radius.elliptical(80, 80)),
                                )
                            )
                        ),Positioned(
                            top: 237,
                            left: 58.345726013183594,
                            child: Row(
                              children: [
                                Icon(Icons.web,color: Colors.white,),
                                SizedBox(
                                  width: 5,
                                ),

                                InkWell(
                                  onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Globalrates()));
                                  },
                                  child:   Text(
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
                            )
                        ),
                        Positioned(
                            top: 272,
                            left: 58.345726013183594,
                            child: Row(
                              children: [
                                Icon(Icons.help,color: Colors.white,),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: (){
                                   _launchURL();


                                  },
                                  child:  Text(
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
                            )
                        ),Positioned(
                            top: 310,
                            left: 58.345726013183594,
                            child: Row(
                              children: [
                                Icon(Icons.gamepad,color: Colors.white,),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Games()));

                                  },
                                  child:  Text(
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
                            )
                        ),
                        

                        SizedBox(
                          height: 10,
                        ),

                    
                        Positioned(
                            top: 447,
                            left: 40.345726013183594,
                            child: Container(
                                width: 156.1904754638672,
                                height: 60,

                                child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                          top: 0,
                                          left: 0,
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                                            },
                                            child: Container(
                                                width: 156.1904754638672,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color : Color.fromRGBO(13, 14, 14, 1),
                                                ),
                                                child: Stack(
                                                    children: <Widget>[
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
                                                    ]
                                                )
                                            ),
                                          )
                                      ),
                                    ]
                                )
                            )
                        ),
                    

                      ]
                  )
              )
            ],

          ),
        

        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: (){
                              _globalKey.currentState!.openDrawer();

                            },
                              child: Icon(Icons.menu,color: Colors.white, size: 40,)),
                        ),
                      ],
                    ),
                  ],
                ),
                SvgPicture.asset("assets/girls.svg",height: 200, width: 200,),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 70,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("BITCOIN : ",style: GoogleFonts.montserrat(textStyle: TextStyle(
                          color: Colors.deepPurpleAccent,
                        )),),
                      ),
                      SizedBox(width: 20,),

                      Text("               ${remoteConfig.getString("Bitcoins")}",style: GoogleFonts.montserrat(textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  height: 70,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("USDT: ",style: GoogleFonts.montserrat(textStyle: TextStyle(
                          color: Colors.deepPurpleAccent,
                        )),),
                      ),
                      SizedBox(width: 20,),

                      Text("                     ${remoteConfig.getString("Usdt")}",style: GoogleFonts.montserrat(textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 70,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("ETHERIUM : ",style: GoogleFonts.montserrat(textStyle: TextStyle(
                          color: Colors.deepPurpleAccent,
                        )),),
                      ),
                      SizedBox(width: 20,),

                      Text("             ${remoteConfig.getString("Etherium")}",style: GoogleFonts.montserrat(textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: (){
                          Activate();
                        },
                        child: GestureDetector(
                          onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>Buycoin()));
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text("Buy",style: GoogleFonts.montserrat(textStyle: TextStyle(
                                color: Colors.deepPurpleAccent,
                              )),),
                            ),

                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 50,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Sellbtc()));
                        },
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text("Sell",style: GoogleFonts.montserrat(textStyle: TextStyle(
                              color: Colors.white,
                            )),),
                          ),

                        ),
                      ),
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
