import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;



class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  TextEditingController admincontroller = TextEditingController();
  TextEditingController Amountcontroller = TextEditingController();
  TextEditingController creditnumcontroller = TextEditingController();
  TextEditingController creditamountcontroller = TextEditingController();
  TextEditingController debitnumcontroller = TextEditingController();
  TextEditingController debitamountcontroller = TextEditingController();
  TextEditingController transactionref = TextEditingController();
  TextEditingController debitref = TextEditingController();
  TextEditingController balancecontroller = TextEditingController();

  final balanceurl = ("https://sandbox.wallets.africa/wallet/balance");
  final crediturl = ("https://sandbox.wallets.africa/wallet/credit");
  final debiturl = ("https://sandbox.wallets.africa/wallet/debit");

  final secret = ('hfucj5jatq8h');
  String bearer = ('uvjqzm5xl6bw');

  dynamic alldata;
  dynamic walletBalance;

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

  Credituser() async {
    var credit = await http.post(
      Uri.parse(crediturl),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $bearer",
      },
      body: jsonEncode(
        {
          "transactionReference": transactionref.text,
          "amount": 1000.0,
          "phoneNumber": creditnumcontroller.text,
          "secretKey": "hfucj5jatq8h"
        },
      ),
    );

    if (credit.statusCode == 200) {
      var data = json.decode(credit.body)['data'];
      print(data);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  'User Credited Successfully',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text(
                      'okay',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
    } else {
      print(credit.statusCode);

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  'Transaction Failed',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text(
                      'Retry',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Credituser();
                    },
                  ),
                ],
              ));
    }
  }

  Future Debituser() async {
    var debit = await http.post(
      Uri.parse(debiturl),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $bearer",
      },
      body: jsonEncode(
        {
          "transactionReference": debitref.text,
          "amount": 100.0,
          "phoneNumber": debitnumcontroller.text,
          "secretKey": "hfucj5jatq8h"
        },
      ),
    );

    if (debit.statusCode == 200) {
      var data = json.decode(debit.body)['data'];
      print(data);
    }
  }

  Future Fetchuserbalance() async {
    var response = await http.post(
      Uri.parse(balanceurl),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $bearer",
      },
      body: jsonEncode(
        {
          "phoneNumber": balancecontroller.text,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserbalance();
    Debituser();
    Fetchuserbalance();
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
               
                //starboy

                SizedBox(
                  height: 90,
                ),
                Text(
                  'CREDIT USER',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: creditnumcontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter User Wallet ID',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 5,
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: transactionref,
                    decoration: InputDecoration(
                      hintText: 'EnterTranction Reference',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: creditamountcontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter Amount',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    if (creditnumcontroller.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please Enter Wallet ID",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else if (creditamountcontroller.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please Enter Amount",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      Credituser();
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height - 640,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('CREDIT ',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                //debit
                Text(
                  'DEBIT USER',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: debitref,
                    decoration: InputDecoration(
                      hintText: 'Enter Reference number',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: debitnumcontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter User Wallet ID',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: debitamountcontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter Amount',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (debitnumcontroller.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please Enter Phone Number",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else if (debitamountcontroller.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please Enter Amount",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  'Are you sure you want to Debit this user?',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                actions: [
                                  FlatButton(
                                    child: Text(
                                      'Yes',
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Debituser().then((value) => {
                                            Navigator.pop(context),
                                            Fluttertoast.showToast(
                                              msg: "User Debit Successfully",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            )
                                          });
                                      // Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      'No',
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ));
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height - 640,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('DEBIT ',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                Text(
                  'VIEW USER BALANCE',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  walletBalance == null ? '0' : walletBalance,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: balancecontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter User Wallet ID',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Fetchuserbalance();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height - 640,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('View Balance ',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
