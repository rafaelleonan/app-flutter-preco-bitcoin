import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco = "0";

  void _recuperarPreco() async {

    Uri url = Uri.parse("https://blockchain.info/ticker");
    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode( response.body );
    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });

    print("Resultado : " + retorno["BRL"]["buy"].toString() );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/bitcoin.png"),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$ $_preco",
                  style: const TextStyle(
                    fontSize: 35
                  ),
                ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.orange),
                  padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(30, 15, 30, 15)),
                ),
                onPressed: _recuperarPreco,
                child: const Text(
                  "Atualizar",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
