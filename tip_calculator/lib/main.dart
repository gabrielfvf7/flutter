import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Tip Calculator",
    home: new TipCalculator()));
}

class TipCalculator extends StatelessWidget {
  double billAmount = 0.0;
  double tipPercentage = 0.0;

  @override
  Widget build(BuildContext context) {
    TextField billAmountField = new TextField(
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        try {
          billAmount = double.parse(value);
        } catch (exception) {
          billAmount = 0.0;
        }
      },
      decoration: new InputDecoration(labelText: "Bill amount(\$)"),
    );

    TextField tipPercentageField = new TextField(
      decoration: new InputDecoration(
        labelText: "Tip %",
        hintText: "15"
      ),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        try {
          tipPercentage = double.parse(value);
        } catch (exception) {
          tipPercentage = 0.0;
        }
      },
    );

    RaisedButton calculateButton = new RaisedButton(
      child: new Text("Calculate"),
      onPressed: () {
        double calculatedTip = billAmount * tipPercentage / 100.0;
        double total = billAmount + calculatedTip;

        AlertDialog dialog = new AlertDialog(
          content: new Text(
            "Tip: \$$calculatedTip \n"
              "Total: \$$total"),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) => dialog
          );
      },
    );

    Container container = new Container(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        children: [billAmountField, tipPercentageField, calculateButton],
      ),
    );

    AppBar appBar = new AppBar(
      title: new Text("Tip Calculator"),
    );

    Scaffold scaffold = new Scaffold(
      appBar: appBar,
      body: container,
    );

    return scaffold;
  }
}