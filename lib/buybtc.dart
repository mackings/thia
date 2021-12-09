import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:thiago_exchange/login.dart';
import 'package:thiago_exchange/finalbuy.dart';
import 'package:url_launcher/url_launcher.dart';


class Buycoin extends StatefulWidget {
  const Buycoin({Key? key}) : super(key: key);

  @override
 BuycoinState createState() => BuycoinState();
}

class BuycoinState extends State<Buycoin> {

  //whatsapp
  var whatsapp = ("https://wa.me/2348167556757?text=Hello%20Thiago Exchange%2C%20%20 %20in%20%20Nice using Your Mobile App");
  void _launchURL() async =>
      await canLaunch(whatsapp) ? await launch(whatsapp) : throw 'Could not even launch $whatsapp';

  //Remote server config
  RemoteConfig remoteConfig = RemoteConfig.instance;
  Future Activate() async{
    bool updated = await remoteConfig.fetchAndActivate();
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration( seconds: 60), minimumFetchInterval: Duration(minutes: 5),
    ));
    if(updated){
      //actions

    }else{
      //reverseacions

    }

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,

        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  SvgPicture.asset("assets/buy.svg",height: MediaQuery.of(context).size.height - 430,  width: MediaQuery.of(context).size.width,),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                   height: MediaQuery.of(context).size.height /10,
                      width: MediaQuery.of(context).size.width - 15,
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
                  height: MediaQuery.of(context).size.height /10,
                      width: MediaQuery.of(context).size.width - 15,
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
                   height: MediaQuery.of(context).size.height /10,
                      width: MediaQuery.of(context).size.width - 15,
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

                  GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            content: Text("Ready to  Buy ?",style: GoogleFonts.montserrat(),),
                            actions: [
                              MaterialButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>finalbuy()));
                                },
                                child: Text("YES",style: GoogleFonts.montserrat(),),
                              ),
                              MaterialButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text("NO",style: GoogleFonts.montserrat(),),
                              ),
                            ],

                          );
                        },
                      );
                    },
                    child: Container(

                      child: Container(
                        height: MediaQuery.of(context).size.height /10,
                      width: MediaQuery.of(context).size.width - 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text("Buy Now",style: GoogleFonts.montserrat(textStyle: TextStyle(
                            color: Colors.white,
                          )),),
                        ),

                      ),

                    ),
                  ),
                ],

              ),
            ),

          ),
        ),
      ),
    );
  }
}
