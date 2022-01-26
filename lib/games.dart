import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_fonts/google_fonts.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  final gameurl = ("https://poki.com/");
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(" Thiago Games",style: GoogleFonts.montserrat(fontSize: 20,color: Colors.white),),
        ),
        url: gameurl);
  }
}
