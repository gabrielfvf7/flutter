import 'package:flutter/material.dart';
import 'package:recover/pergunta.dart';
import 'package:recover/resposta.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int indicePergunta;
  final Function responderPergunta;

  Quiz({
    @required this.questions,
    @required this.indicePergunta,
    @required this.responderPergunta,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Pergunta(questions[indicePergunta]['pergunta']),
        ...(questions[indicePergunta]['respostas'] as List<Map<String, Object>>)
            .map((pergunta) {
          return Resposta(
              () => responderPergunta(pergunta['score']), pergunta['text']);
        }).toList(),
      ],
    );
  }
}
