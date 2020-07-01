import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controllerAlcohol = TextEditingController();
  final TextEditingController _controllerGasoline = TextEditingController();
  String _result = "";

  void _calculate() {
    double priceAlcohol =
        double.tryParse(_controllerAlcohol.text.replaceFirst(",", "."));

    double priceGasoline =
        double.tryParse(_controllerGasoline.text.replaceFirst(",", "."));

    if (priceAlcohol == null || priceGasoline == null) {
      setState(() {
        _result = "Número inválido.";
      });
    } else {
      String text = "";
      if ((priceAlcohol / priceGasoline) >= 0.7) {
        text = "Melhor abastecer com gasolina.";
      } else {
        text = "Melhor abastecer com álcool.";
      }

      setState(() {
        _result = text;
      });

      _reset();
    }
  }

  void _reset() {
    _controllerGasoline.text = "";
    _controllerAlcohol.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Álcool ou Gasolina"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset("images/logo.png"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Saiba qual a melhor opção para abastecimento do seu carro",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço Álcool, ex: 1.59",
                ),
                style: TextStyle(
                  fontSize: 22,
                ),
                controller: _controllerAlcohol,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço Gasolina, ex: 3.59",
                ),
                style: TextStyle(
                  fontSize: 22,
                ),
                controller: _controllerGasoline,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: _calculate,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  _result,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
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
