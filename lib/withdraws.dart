import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Withdraws extends StatefulWidget {
  const Withdraws({Key? key}) : super(key: key);

  @override
  _WithdrawsState createState() => _WithdrawsState();
}

class _WithdrawsState extends State<Withdraws> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _amount = TextEditingController();

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
              "<h1>${usermail}  with Wallet Address ${_controller.text}Has Requested to Withdraw ${_amount.text} , Kindly Modify</h1>"
        }));

    if (response.statusCode == 200) {
      result = json.decode(response.body);
      print('Admin Notified Successfully');

      print(result);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Icon(Icons.arrow_back_ios,color: Colors.white,),
              Text("Withdraw Funds",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                "Note 1:  Withdrawals from your accounts would automatically sent a Withdraw request ",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                "Note 2 : There would be no reverse of any withdraw requests to your account unless there is a glitch  ",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                "Note 3 :  You are free to contact the support Team for anhy kind of Assistance and   Help as it is Free",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width - 25,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _amount,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 15) {
                      return 'Please enter Withdraw Amount';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: " Enter Wallet Amount",
                    hintStyle: GoogleFonts.montserrat(
                      color: Colors.black,
                    ),
                    suffixIcon: Icon(
                      Icons.monetization_on,
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
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width - 25,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controller,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 15) {
                      return 'Please enter Withdraw Amount';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: " Enter Wallet Address",
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
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              mailgun().whenComplete(() => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(
                          "Withdraw Request Sent",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        content: Text(
                          "Your Withdraw Request has been sent to the Admin",
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
                              "OK",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Withdraws()));
                            },
                          )
                        ],
                      )));
            },
            child: Container(
              height: MediaQuery.of(context).size.height - 640,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  ' Withdraw ',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
