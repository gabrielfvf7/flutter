import 'package:flutter/material.dart';

class Pergunta extends StatelessWidget {
  final String perguntaTxt;

  Pergunta(this.perguntaTxt);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      child: Text(
        perguntaTxt,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
