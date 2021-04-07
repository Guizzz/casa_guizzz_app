import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Casa Guizzz app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Casa Guizzz App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String risposta = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 8,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(10.0),
                        color: Colors.blue,
                      ),
                    ),
                    onTap: blink,
                  ),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 8,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(10.0),
                        color: Colors.red,
                      ),
                    ),
                    onTap: endBlink,
                  ),
                ],
              ),
            ),
            Text(risposta),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<bool> blink() async {
    final url = Uri.http("192.168.1.120:8889", "/blink");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        risposta = response.body;
      });
    } else {
      setState(() {
        risposta = "Errore: " + response.body;
      });
    }
  }

  Future<bool> endBlink() async {
    final url = Uri.http("192.168.1.120:8889", "/endblink");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        risposta = response.body;
      });
    } else {
      setState(() {
        risposta = "Errore: " + response.body;
      });
    }
  }
}
