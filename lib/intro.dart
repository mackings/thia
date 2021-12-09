import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thiago_exchange/createacc.dart';
import 'package:thiago_exchange/login.dart';
import "package:video_player/video_player.dart";

class Intro1 extends StatefulWidget {
  const Intro1({Key? key}) : super(key: key);

  @override
  _Intro1State createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  VideoPlayerController _mycontroller = VideoPlayerController.asset(
    "assets/btcvideo.mp4",
  );

  @override
  void initState() {
    // TODO: implement initState

    _mycontroller.initialize().then((_) {
      _mycontroller.play();
      _mycontroller.setLooping(true);
      Timer(Duration(seconds: 10), () => _mycontroller.pause());

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.deepPurpleAccent,
            body: Stack(
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SizedBox(
                      width: _mycontroller.value.size.width,
                      height: _mycontroller.value.size.height,
                      child: SizedBox(
                        width: _mycontroller.value.size.width,
                        height: _mycontroller.value.size.height,
                        child: VideoPlayer(_mycontroller),
                      ),
                    ),
                  ),
                ),
                Enter(),
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _mycontroller.dispose();
  }
}

class Enter extends StatefulWidget {
  const Enter({Key? key}) : super(key: key);

  @override
  _EnterState createState() => _EnterState();
}

class _EnterState extends State<Enter> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 390,
          ),
          //SvgPicture.asset(
          // "assets/exchange.svg",
          //height: 150,
          //width: 150,
          // ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Thiago Exchange",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Center(
            child: Text(
              "Your Best Plug for Crypto Trades",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateAcc()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 12, 
                width: MediaQuery.of(context).size.width -40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Get Started",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 12, 
                width: MediaQuery.of(context).size.width -40,
                //width: 300,
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Sign in",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
