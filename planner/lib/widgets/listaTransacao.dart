import 'package:flutter/material.dart';
import 'package:planner/models/transacao.dart';
import 'package:intl/intl.dart';

class listaTransacao extends StatelessWidget {
  final List<Transacao> transacoes;

  listaTransacao(this.transacoes);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) {
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
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "R\$${transacoes[index].amount.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transacoes[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat("dd/MM/yyyy - HH:mm")
                          .format(transacoes[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: transacoes.length,
      ),
    );
  }
}
