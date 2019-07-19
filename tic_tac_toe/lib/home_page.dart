import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonsList;
  var player;
  var bot;
  var activePlayer;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player = new List();
    bot = new List();
    activePlayer = 1;

    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Colors.green;
        activePlayer = 2;
        player.add(gb.id);
      } else {
        gb.text = "0";
        gb.bg = Colors.red;
        activePlayer = 1;
        bot.add(gb.id);
      }
      gb.enabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Tic Tac toe"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 9.0,
          mainAxisSpacing: 9.0,
        ),
        itemCount: buttonsList.length,
        itemBuilder: (context, i) => new SizedBox(
          width: 100.0,
          height: 100.0,
          child: new RaisedButton(
            padding: const EdgeInsets.all(8.0),
            onPressed: buttonsList[i].enabled?() => playGame(buttonsList[i]): null,
            child: new Text(
              buttonsList[i].text,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            color: buttonsList[i].bg,
            disabledColor: buttonsList[i].bg,
          ),
        ),
      ),
    );
  }
}