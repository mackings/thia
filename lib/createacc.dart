import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:thiago_exchange/login.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:http/http.dart' as http;

class CreateAcc extends StatefulWidget {
  const CreateAcc({Key? key}) : super(key: key);

  @override
  _CreateAccState createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _Btccontroller = TextEditingController();
  TextEditingController _phonenumber = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

   final Walleturl = ("https://sandbox.wallets.africa/wallet/generate");
  final secret = ('hfucj5jatq8h');
  String bearer = ('uvjqzm5xl6bw');

  dynamic WalletID;



  Future Createwallet() async {

    final response = await http.post(
      Uri.parse(Walleturl),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $bearer",
      },
      body: jsonEncode(
        {
          
  "firstName": _fullnameController.text,
  "lastName": _fullnameController.text,  
  "Bvn":_phonenumber.text, 
  "email": _emailController.text,  
  "secretKey": secret,
  "dateOfBirth": "1946-01-12",
  "phoneNumber": 0000000000,
  "password": _passwordController.text,
  "currency": "NGN"
          
          
      
          
        },
      ),
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      setState(() {
        WalletID = responseJson['data']['phoneNumber'];
      });

     
    } else {
      print(response.statusCode);
      print(bearer);
    }


    
    var walletbox = Hive.box('user');
    await walletbox.put('walletid', WalletID).whenComplete(() => print("Hive saved" + WalletID));

    //print(response.body);
  }








  storeuserdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _emailController.text);
    prefs.setString('password', _passwordController.text);
    prefs.setString('fullname', _fullnameController.text);
    prefs.setString('phonenumber', _phonenumber.text);
    prefs.setString('btcaddress', _Btccontroller.text);

    //FirebaseFirestore.instance
    //    .collection('users')
     //   .doc(_emailController.text)
     //   .set({
     // 'email': _emailController.text,
     // 'password': _passwordController.text,
     // 'fullname': _fullnameController.text,
    //  'phonenumber': _phonenumber.text,
   //   'btcaddress': _Btccontroller.text,
   // });

     FirebaseFirestore.instance.collection(" Registered Users").add({
                        "Account Name":_fullnameController.text,
                        "Email Address": _emailController.text,
                        "BTC Wallet":_Btccontroller.text,
                        "Phone Number": _phonenumber.text,
                        "Date Added": DateTime.now(),
                      });


    print(prefs.getString('email'));
   
  }

  Createuser() async {
    _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(), password: _passwordController.text.trim())
        .then((user) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success",style: GoogleFonts.montserrat(),),
              content: Text("Account created successfully",style: GoogleFonts.montserrat(),),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK",style: GoogleFonts.montserrat(),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }).catchError((e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error ",style: GoogleFonts.montserrat(),),
              content: Text(e.message),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK",style: GoogleFonts.montserrat(),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: Text(
                        "Create Your Account",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height /12,
                      width: MediaQuery.of(context).size.width - 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _fullnameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Enter Full Name",
                              hintStyle: GoogleFonts.montserrat(
                                color: Colors.black,

                              ),
                              suffixIcon: Icon(
                                Icons.account_circle,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height /12,
                      width: MediaQuery.of(context).size.width - 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _Btccontroller,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 10) {
                                return 'Please enter your BTC Address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Enter BTC Address",
                              hintStyle: GoogleFonts.montserrat(
                                color: Colors.black,
                              ),
                              suffixIcon: Icon(
                                Icons.qr_code,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //yeah
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                       height: MediaQuery.of(context).size.height /12,
                      width: MediaQuery.of(context).size.width - 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value!.isEmpty ){
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Enter Your Email",
                              hintStyle: GoogleFonts.montserrat(
                                color: Colors.black,
                              ),
                              suffixIcon: Icon(
                                Icons.alternate_email,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height /12,
                      width: MediaQuery.of(context).size.width - 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _phonenumber,
                            validator: (value) {
                              if (value!.isEmpty || value.length > 11) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Enter Your Phone Number",
                              hintStyle: GoogleFonts.montserrat(
                                color: Colors.black,
                              ),
                              suffixIcon: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height /12,
                      width: MediaQuery.of(context).size.width - 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Please enter a Strong Password';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Enter Your Password",
                              hintStyle: GoogleFonts.montserrat(
                                color: Colors.black,
                              ),
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
        
                    SizedBox(
                      height: 20,
                    ),
        
                    Container(
                    height: MediaQuery.of(context).size.height /12,
                      width: MediaQuery.of(context).size.width - 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _confirmpasswordController,style: GoogleFonts.montserrat(
                              color: Colors.black,
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value != _passwordController.text) {
                                return 'Passwords Do not Match';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Confirm Your Password",
                              hintStyle: GoogleFonts.montserrat(
                                color: Colors.black,
                              ),
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                       height: MediaQuery.of(context).size.height /12,
                      width: MediaQuery.of(context).size.width - 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
        
                                  Createuser();
                                  storeuserdetails();
                                 // Notify();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                } else {}
        
                                //Createaccount();
                                //Notify();
                                // Navigator.push(
                                //   context,
                                // MaterialPageRoute(
                                //     builder: (context) => Login()));
                              },
                              child: Text(
                                "Create Account",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
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
