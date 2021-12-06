import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
          title: Text(" Thiago Games"),
        ),
        url: gameurl);
  }
}
