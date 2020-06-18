import 'package:flutter/material.dart';
import 'package:recover/quiz.dart';
import 'package:recover/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  static const _questions = [
    {
      'pergunta': "Qual sua cor favorita?",
      'respostas': [
        {
          'text': 'Azul',
          'score': 10,
        },
        {
          'text': 'Vermelho',
          'score': 5,
        },
        {
          'text': 'Verde',
          'score': 2,
        },
        {
          'text': 'Preto',
          'score': 8,
        }
      ],
    },
    {
      'pergunta': "Qual seu animal favorito?",
      'respostas': [
        {
          'text': 'Cachorro',
          'score': 10,
        },
        {
          'text': 'Gato',
          'score': 10,
        },
        {
          'text': 'Macaco',
          'score': 10,
        },
        {
          'text': 'Leão',
          'score': 10,
        }
      ],
    },
  ];
  var indicePergunta = 0;
  var _totalScore = 0;

  void reiniciarQuiz() {
    setState(() {
      indicePergunta = 0;
      _totalScore = 0;
    });
  }

  void responderPergunta(int score) {
    _totalScore += score;
    setState(() {
      indicePergunta += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Meu App')),
        body: indicePergunta < _questions.length
            ? Quiz(
                indicePergunta: indicePergunta,
                questions: _questions,
                responderPergunta: responderPergunta)
            : Result(_totalScore, reiniciarQuiz),
      ),
    );
  }
}
