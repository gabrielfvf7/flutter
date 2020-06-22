import 'package:flutter/material.dart';
import 'package:planner/transacao.dart';
import './transacao.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transacao> transacoes = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text("Chart"),
                elevation: 5,
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Título"),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "Valor"),
                    ),
                    FlatButton(
                      onPressed: () => null,
                      child: Text("Adicionar"),
                      textColor: Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
            Column(
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
                            DateFormat("dd/MM/yyyy - HH:mm")
                                .format(transacao.date),
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
            ),
          ],
        ));
  }
}
