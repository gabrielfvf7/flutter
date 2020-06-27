import 'package:flutter/material.dart';
import './models/transacao.dart';
import './widgets/listaTransacao.dart';
import './widgets/nova_transacao.dart';

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  String titleInput;
  String amountInput;

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NovaTransacao(_addTransacao);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text("Chart"),
                elevation: 5,
              ),
            ),
            listaTransacao(_transacoes),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
