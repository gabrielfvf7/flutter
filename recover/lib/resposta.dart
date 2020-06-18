import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final Function funHandler;
  final String btnText;

  Resposta(this.funHandler, this.btnText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(btnText),
        onPressed: funHandler,
      ),
    );
  }
}
