import 'package:flutter/material.dart';
import 'package:planner/models/transacao.dart';
import 'package:intl/intl.dart';

class listaTransacao extends StatelessWidget {
  final List<Transacao> transacoes;
  final Function deleteTransaction;

  listaTransacao(this.transacoes, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transacoes.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'Sem transações',
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\$${transacoes[index].amount}'))),
                  ),
                  title: Text(transacoes[index].title),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(transacoes[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          textColor: Colors.red,
                          icon: Icon(Icons.delete),
                          label: Text("Delete"),
                          onPressed: () =>
                              deleteTransaction(transacoes[index].id),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              deleteTransaction(transacoes[index].id),
                        ),
                ),
              );
            },
            itemCount: transacoes.length,
          );
  }
}
