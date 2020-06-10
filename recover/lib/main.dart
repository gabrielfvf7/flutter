import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var questions = ["Qual sua cor favorita?", "Qual seu animal favorito?"];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Meu App')),
        body: Column(
          children: [
            Text("A pergunta"),
            RaisedButton(child: Text("Resposta 1"), onPressed: null),
            RaisedButton(child: Text("Resposta 2"), onPressed: null),
            RaisedButton(child: Text("Resposta 3"), onPressed: null),
          ],
        ),
      ),
    );
  }
}
