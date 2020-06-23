import 'package:flutter/material.dart';
import 'package:planner/models/transacao.dart';
import 'package:intl/intl.dart';

class listaTransacao extends StatelessWidget {
  final List<Transacao> transacoes;

  listaTransacao(this.transacoes);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transacoes.map((transacao) {
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 2,
                    color: Colors.purple,
                  )),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "R\$${transacao.amount.toString()}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transacao.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat("dd/MM/yyyy - HH:mm").format(transacao.date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
