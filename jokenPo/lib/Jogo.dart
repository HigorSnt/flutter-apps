import 'package:flutter/material.dart';
import 'dart:math';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _appImage = AssetImage("images/padrao.png");
  var _message = "Escolha uma opção abaixo";

  void _selectedOption(String userChoice) {
    var options = ["pedra", "papel", "tesoura"];
    var number = Random().nextInt(3);
    var appChoice = options[number];

    switch (appChoice) {
      case "pedra":
        setState(() {
          this._appImage = AssetImage("images/pedra.png");
        });
        break;
      case "papel":
        setState(() {
          this._appImage = AssetImage("images/papel.png");
        });
        break;
      case "tesoura":
        setState(() {
          this._appImage = AssetImage("images/tesoura.png");
        });
        break;
      default:
        setState(() {
          this._appImage = AssetImage("images/padrao.png");
        });
    }

    var winner = "";

    if (
      (userChoice == "pedra" && appChoice == "tesoura") ||
      (userChoice == "tesoura" && appChoice == "papel") ||
      (userChoice == "papel" && appChoice == "pedra")
    ) {
      winner = "Parabéns!!! Você ganhou :)";
    } else if (
      (appChoice == "pedra" && userChoice == "tesoura") ||
      (appChoice == "tesoura" && userChoice == "papel") ||
      (appChoice == "papel" && userChoice == "pedra")
    ) {
      winner = "Parabéns!!! Você perdeu :(";
    } else {
      winner = "Empatamos ;)";
    }

    setState(() {
      this._message = winner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JokenPo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 32,
              bottom: 16,
            ),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Image(
            image: this._appImage,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 32,
              bottom: 16,
            ),
            child: Text(
              _message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => _selectedOption("pedra"),
                child: Image.asset(
                  "images/pedra.png",
                  height: 100,
                ),
              ),
              GestureDetector(
                onTap: () => _selectedOption("papel"),
                child: Image.asset(
                  "images/papel.png",
                  height: 100,
                ),
              ),
              GestureDetector(
                onTap: () => _selectedOption("tesoura"),
                child: Image.asset(
                  "images/tesoura.png",
                  height: 100,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
