import 'package:flutter/material.dart';
import './listaTransacao.dart';
import './nova_transacao.dart';
import '../models/transacao.dart';

class TransacoesUser extends StatefulWidget {
  @override
  _TransacoesUserState createState() => _TransacoesUserState();
}

class _TransacoesUserState extends State<TransacoesUser> {
  final List<Transacao> _transacoes = [
    Transacao(
      id: 't1',
      title: 'Sapatos',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transacao(
      id: 't2',
      title: 'Hamburguer',
      amount: 25.00,
      date: DateTime.now(),
    ),
  ];

  void _addTransacao(String title, double amount) {
    final novaTransacao = Transacao(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _transacoes.add(novaTransacao);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NovaTransacao(_addTransacao),
        listaTransacao(_transacoes),
      ],
    );
  }
}
