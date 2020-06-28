import 'package:flutter/material.dart';
import 'package:planner/widgets/chart.dart';
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
      theme: ThemeData(
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 10,
              ),
            ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transacao> _transacoes = [
    // Transacao(
    //   id: 't1',
    //   title: 'Sapatos',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transacao(
    //   id: 't2',
    //   title: 'Hamburguer',
    //   amount: 25.00,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transacao> get _recentTransactions {
    return _transacoes
        .where(
          (transacao) => transacao.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _addTransacao(String title, double amount, DateTime chosenDate) {
    final novaTransacao = Transacao(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
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

  void _deleteTransaction(String id) {
    setState(() {
      _transacoes.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter App',
        ),
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
            Chart(_recentTransactions),
            listaTransacao(_transacoes, _deleteTransaction),
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
