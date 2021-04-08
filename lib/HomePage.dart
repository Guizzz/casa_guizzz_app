import 'package:casa_guizzz_app/Decorations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  String risposta = "";
  double ledValue = 0;
  final WebSocketChannel channel = IOWebSocketChannel.connect('ws://192.168.1.120:8080');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 8,
                        decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(10.0),
                            color: Colors.white,
                            boxShadow: [Decorations.shadow()]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                              child: Text(
                            "Blink",
                            style: new TextStyle(color: Colors.black),
                          )),
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
                            color: Colors.white,
                            boxShadow: [Decorations.shadow()]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                              child: Text(
                                "Stop",
                                style: new TextStyle(color: Colors.black),
                              )
                          ),
                        ),
                      ),
                      onTap: endBlink,
                    ),
                  ],
                ),
              ),
              Slider(
                  value: ledValue,
                  min: 0,
                  max: 255,
                  label: ledValue.toInt().toString(),
                  onChanged: (double value) {
                    setState(() {
                      setLED(value.toInt());
                      ledValue = value;
                    });
                  }),
              Text(risposta),
              StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  return Text(snapshot.hasData ? '${snapshot.data}' : '');
                },
              )

        ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<bool> setLED(int val) async {
    Map<String, String> parameters = {'ledVal': val.toString()};
    final url = Uri.http("192.168.1.120:8889", "/setLED", parameters);
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
