import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thiago_exchange/adminpage.dart';

class Pass extends StatefulWidget {
  const Pass({Key? key}) : super(key: key);

  @override
  _PassState createState() => _PassState();
}

class _PassState extends State<Pass> {
  TextEditingController auth = TextEditingController();
  var auth1 = "00000";

  unlockpage() {
    if (auth.text.toString() == auth1.toString()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Admin()),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Not Authorized',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: Text(
                'Try Again in 10 seconds...',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text(
                    'Ok',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 190),
              Center(
                child: Text(
                  'Hello Thiago Admins',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Kindly Aunthenticate Your  ID',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: auth,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Your ID',
                    hintStyle: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
              SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 50,
                child: MaterialButton(
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    unlockpage();
                  },
                  child: Text(
                    'Authenticate',
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
            ],
          ),
        ),
      ),
    );
  }
}
