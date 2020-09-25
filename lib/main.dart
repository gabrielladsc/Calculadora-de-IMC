import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController altura = TextEditingController();
  TextEditingController peso = TextEditingController();

  GlobalKey<FormState> _formulario = GlobalKey<FormState>();

  String _resultado = "Por favor, insira seus dados\n para calcular o IMC.";
  String _pesoMin = "";
  String _pesoMax = "";

  void reset() {
    setState(() {
      altura.text = "";
      peso.text = "";
      _resultado = "Por favor, insira seus dados\n para calcular o IMC.";
      _pesoMin = "";
      _pesoMax = "";
    });
  }

  void imc() {
    setState(() {
      double alturaPessoa = double.parse(altura.text);
      double pesoPessoa = double.parse(peso.text);
      double imc = pesoPessoa / (alturaPessoa * alturaPessoa);
      double pesoMinimo, pesoMaximo;

      if (imc < 18.5 || imc > 24.9) {
        pesoMinimo = 18.5 * alturaPessoa * alturaPessoa;
        pesoMaximo = 24.9 * alturaPessoa * alturaPessoa;
        _pesoMin = "Peso ideal mínimo: ${pesoMinimo.toStringAsPrecision(3)} kg";
        _pesoMin = "Peso ideal máximo: ${pesoMaximo.toStringAsPrecision(3)} kg";
      }

      if (imc < 18.5) {
        _resultado =
            "Abaixo do peso ideal, IMC: (${imc.toStringAsPrecision(3)})";
      } else if (imc < 24.9) {
        _resultado = "Peso ideal: IMC: (${imc.toStringAsPrecision(3)})";
        _pesoMax = "";
        _pesoMin = "";
      } else if (imc < 29.9) {
        _resultado = "Sobrepeso: IMC: (${imc.toStringAsPrecision(3)})";
      } else if (imc < 34.9) {
        _resultado = "Obesidade grau I: IMC: (${imc.toStringAsPrecision(3)})";
      } else if (imc < 39.9) {
        _resultado = "Obesidade grau II: (${imc.toStringAsPrecision(3)})";
      } else {
        _resultado = "Obesidade grau III: (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: reset),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formulario,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.people_outline,
                size: 120.0,
                color: Colors.grey,
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (m)",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey),
                  controller: altura,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Entre com a altura";
                    }
                  }),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey),
                  controller: peso,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Entre com o peso";
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formulario.currentState.validate()) {
                        imc();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                    ),
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25.0,
                ),
              ),
              Container(padding: EdgeInsets.all(10.0)),
              Text(
                _pesoMin,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25.0,
                ),
              ),
              Text(
                _pesoMax,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
