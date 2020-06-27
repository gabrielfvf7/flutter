import 'package:flutter/material.dart';

class NovaTransacao extends StatefulWidget {
  final Function addTransacao;

  NovaTransacao(this.addTransacao);

  @override
  _NovaTransacaoState createState() => _NovaTransacaoState();
}

class _NovaTransacaoState extends State<NovaTransacao> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) return;
    widget.addTransacao(
      titleController.text,
      double.parse(amountController.text),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Título"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Valor"),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              onPressed: submitData,
              child: Text("Adicionar"),
              textColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
