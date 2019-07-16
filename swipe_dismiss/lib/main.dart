import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(body: MyHomePage(title: 'Swipe to dismiss')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final List<String> items = new List<String>.generate(30, (i) => "Item ${i+1}");

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Swipe to dismiss"), ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(items[index]),
            onDismissed: (direction) {
              items.removeAt(index);
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: Text("Item dismissed"),
                action: SnackBarAction(
                  label: "Undo",
                  onPressed: () {
                    items.add("Item ${index+1}");
                  },
                ),
              ));
            },
            background: Container(
              color: Colors.red,
            ),
            child: ListTile(
              title: Text("${items[index]}"),
            ),
          );
        },
      ),
    );
  }
}
