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
            email: _emailController.text.trim(), password: _passwordController.text.trim())
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
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Close',
                  style: TextStyle(fontFamily: 'Montserrat'),
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 90,
                        ),
                        SvgPicture.asset(
                          "assets/socialgirl.svg",
                          height: 300,
                          width: 300,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          width: 300,
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
                                controller: _emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: " Enter Email",
                                  hintStyle: GoogleFonts.montserrat(
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.email,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          width: 300,
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
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: " Enter Password",
                                  hintStyle: GoogleFonts.montserrat(
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.lock_open,
                                    color: Colors.deepPurpleAccent,
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
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                        color: Colors.deepPurpleAccent,
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
                                    color: Colors.deepPurpleAccent,
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
    );
  }

  Tradeground() {}
}
