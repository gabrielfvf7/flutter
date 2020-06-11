import 'package:flutter/material.dart';
import 'package:recover/pergunta.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var indicePergunta = 0;

  void responderPergunta() {
    setState(() {
      indicePergunta += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var questions = ["Qual sua cor favorita?", "Qual seu animal favorito?"];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Meu App')),
        body: Column(
          children: [
            Pergunta(questions[indicePergunta]),
            RaisedButton(
                child: Text("Resposta 1"), onPressed: responderPergunta),
            RaisedButton(
                child: Text("Resposta 2"), onPressed: responderPergunta),
            RaisedButton(
                child: Text("Resposta 3"), onPressed: responderPergunta),
          ],
        ),
      ),
    );
  }
}
