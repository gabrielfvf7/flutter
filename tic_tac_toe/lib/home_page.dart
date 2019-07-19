import 'package:flutter/material.dart';
import 'package:tic_tac_toe/custom_dialog.dart';
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
      checkWinner();
    });
  }

  void checkWinner() {
    var winner = -1;
    if (player.contains(1) && player.contains(2) && player.contains(3)) {
      winner = 1;
    }
    if (bot.contains(1) && bot.contains(2) && bot.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player.contains(4) && player.contains(5) && player.contains(6)) {
      winner = 1;
    }
    if (bot.contains(4) && bot.contains(5) && bot.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player.contains(7) && player.contains(8) && player.contains(9)) {
      winner = 1;
    }
    if (bot.contains(7) && bot.contains(8) && bot.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player.contains(1) && player.contains(4) && player.contains(7)) {
      winner = 1;
    }
    if (bot.contains(1) && bot.contains(4) && bot.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player.contains(2) && player.contains(5) && player.contains(8)) {
      winner = 1;
    }
    if (bot.contains(2) && bot.contains(5) && bot.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player.contains(3) && player.contains(6) && player.contains(9)) {
      winner = 1;
    }
    if (bot.contains(3) && bot.contains(6) && bot.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player.contains(1) && player.contains(5) && player.contains(9)) {
      winner = 1;
    }
    if (bot.contains(1) && bot.contains(5) && bot.contains(9)) {
      winner = 2;
    }

    if (player.contains(3) && player.contains(5) && player.contains(7)) {
      winner = 1;
    }
    if (bot.contains(3) && bot.contains(5) && bot.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Player 1 Won",
                "Press the button to reset", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Bot  Won",
                "Press the button to reset", resetGame));
      }
    }
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
     buttonsList = doInit(); 
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