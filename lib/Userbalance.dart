import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;



class Userbalance extends StatefulWidget {
  const Userbalance({Key? key}) : super(key: key);

  @override
  _UserbalanceState createState() => _UserbalanceState();
}

class _UserbalanceState extends State<Userbalance> {
  TextEditingController admincontroller = TextEditingController();
  TextEditingController Amountcontroller = TextEditingController();

  final balanceurl = ("https://sandbox.wallets.africa/wallet/balance");
  final secret = ('hfucj5jatq8h');
  String bearer = ('uvjqzm5xl6bw');

  dynamic alldata;
  String? walletBalance;

  Future getuserbalance() async {
    var response = await http.post(
      Uri.parse(balanceurl),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $bearer",
      },
      body: jsonEncode(
        {
          "phoneNumber": admincontroller.text,
          "secretKey": 'hfucj5jatq8h',
          "currency": "NGN",
        },
      ),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'];
      setState(() {
        walletBalance = '${data['walletBalance']}';
      });
    } else {
      throw Exception('Failed to load post');
    }
  }

  SavebalancetoHivedb() async {
    await Hive.openBox('user');

    var box = Hive.box('user');
    box.put('walletBalance', walletBalance);
    print(box.get('walletBalance'));
    //print(prefs.getString('walletBalance' + 'From SharedPreferences'));
  }

   final CarouselController _controller = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserbalance();
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
                const SizedBox(
                  height: 50,
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
                

              //  Text( 'Wallet Balance',
                //  style: GoogleFonts.lato(
                  //  textStyle: const TextStyle(
                  //    fontSize: 20,
                   //   color: Colors.white,
                   //   fontWeight: FontWeight.bold,
                //    ),
                //  ),
              //  ),
                const SizedBox( height: 70,),

                Container(
                  height: MediaQuery.of(context).size.height -600,
                  width: MediaQuery.of(context).size.width -20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text( '$walletBalance',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  )
                ),

                const SizedBox(
                  height: 40,
                ),

                 TextFormField(
                  controller: admincontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Wallet Address',
                    labelStyle: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),


                
                Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Center(
                        child: Text(
                        'View Balance',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                        
                        
                      )



                      ),
                      SizedBox(
                        width: 20,
                      ),



                       Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Center(
                        child: Text(
                        'Save Balance',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                        
                        
                      )
                      )

                    
                  
                    
                   
                  ],
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
