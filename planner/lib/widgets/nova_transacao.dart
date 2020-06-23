import 'package:flutter/material.dart';

class NovaTransacao extends StatelessWidget {
  final Function addTransacao;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NovaTransacao(this.addTransacao);

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
            ),
            FlatButton(
              onPressed: () => addTransacao(
                titleController.text,
                double.parse(amountController.text),
              ),
              child: Text("Adicionar"),
              textColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
