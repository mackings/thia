import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thiago_exchange/tradeground.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool visible = true;
  bool notVisible = false;
  void showpass(){
    setState(() {
      visible = !visible;
      notVisible = !notVisible;
    });
  }

  //you can use this to check if the user is logged in

  Login() async {
    var email = _emailController.text;
    var password = _passwordController.text;

    FirebaseAuth Login = FirebaseAuth.instance;
    await Login.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());

    if (Login.currentUser!.emailVerified) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TradeGround()),
      );
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Invalid email or password"),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future Signinconfig() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    _auth
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((user) async {
      if (user != null) {
        // setState(() {
        //  loading = true;
        // });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', _emailController.text);
        prefs.setString('password', _passwordController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TradeGround()));
        print(prefs.getString("email"));
      }
    }).catchError((e) {
      // print(e);
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Error Loging in',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            content: Text(
              e.message,
              style:  GoogleFonts.montserrat(),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Close',
                  style:  GoogleFonts.montserrat(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
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
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          SvgPicture.asset(
                            "assets/loginguys.svg",
                            height: MediaQuery.of(context).size.height - 430,
                            width: MediaQuery.of(context).size.width - 200,
                          ),
                          SizedBox(
                            height: 40,
                          ),

                          Text(
                            "Hello User",
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),

                           SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Kindly Login to continue",
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Your Email";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _emailController.text = value!;
                                    });
                                  },
                                  controller: _emailController,style: GoogleFonts.montserrat(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: " Enter Email",
                                    
                                    errorStyle: GoogleFonts.montserrat(
                                        color: Colors.deepPurpleAccent),
                                    hintStyle: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                      size: 30,
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Your Password";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _passwordController.text = value!;
                                    });
                                  },
                                  controller: _passwordController,style: GoogleFonts.montserrat(),
                                  obscureText: notVisible,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: " Enter Password",
                                    errorStyle: GoogleFonts.montserrat(
                                        color: Colors.deepPurpleAccent),
                                    hintStyle: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize:18 
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          
                                        });
                                      },
                                      child: Icon(
                                        Icons.lock_open,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Signinconfig();
                                // Login();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Error",
                                        style: GoogleFonts.montserrat(),
                                      ),
                                      content: Text(
                                        "Invalid email or password",
                                        style: GoogleFonts.montserrat(),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Close",
                                              style: GoogleFonts.montserrat()),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                //Fluttertoast.showToast(msg: "Invalid Entries");
                              }
                            },
                            child: Container(
                               height: MediaQuery.of(context).size.height /12,
                              width: MediaQuery.of(context).size.width - 25,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Login",
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Tradeground() {}
}
