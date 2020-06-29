import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NovaTransacao extends StatefulWidget {
  final Function addTransacao;

  NovaTransacao(this.addTransacao);

  @override
  _NovaTransacaoState createState() => _NovaTransacaoState();
}

class _NovaTransacaoState extends State<NovaTransacao> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null)
      return;
    widget.addTransacao(
      titleController.text,
      double.parse(amountController.text),
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) => value != null
        ? {
            setState(() {
              selectedDate = value;
            })
          }
        : null);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
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
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? "No date chosen"
                            : "Data escolhida: ${DateFormat("dd/MM/yyyy").format(selectedDate)}",
                      ),
                    ),
                    FlatButton(
                      textColor: Colors.purple,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitData,
                child: Text("Adicionar"),
                color: Colors.purple,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
