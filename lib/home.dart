import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String currentPlayer = "X";
  List<String> board = ["", "", "", "", "", "", "", "", ""];
  int oWin = 0, xWin = 0, moves = 0;

  bool checkWinner(String p) {
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] == p && board[i * 3 + 1] == p && board[i * 3 + 2] == p) {
        return true;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (board[i] == p && board[i + 3] == p && board[i + 6] == p) {
        return true;
      }
    }
    if ((board[0] == p && board[4] == p && board[8] == p) ||
        (board[2] == p && board[4] == p && board[6] == p)) {
      return true;
    }
    return false;
  }

  Widget showWinDialog(String s) {
    return AlertDialog(
      title: Center(
          child: Text("Player $s wins!",
              style: const TextStyle(fontFamily: "Main", fontSize: 20))),
      actions: <Widget>[
        TextButton(
          child: const Center(child: Text("Play Again")),
          onPressed: () {
            board = ["", "", "", "", "", "", "", "", ""];
            currentPlayer = "X";
            moves = 0;
            setState(() {});
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget showDrawDialog() {
    return AlertDialog(
      title: const Center(
          child: Text("Game Draw!",
              style: TextStyle(fontFamily: "Main", fontSize: 20))),
      actions: <Widget>[
        TextButton(
          child: const Center(child: Text("Play Again")),
          onPressed: () {
            board = ["", "", "", "", "", "", "", "", ""];
            currentPlayer = "X";
            moves = 0;
            setState(() {});
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(33, 33, 33, 100),
          title: const Text("Tic Tac Toe",
              style: TextStyle(
                  fontSize: 25, fontFamily: "Main", color: Colors.white)),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: const Center(
                                  child: Text("Reset the Game?",
                                      style: TextStyle(
                                          fontFamily: "Main", fontSize: 20))),
                              actions: [
                                TextButton(
                                  child: const Center(child: Text("Yes")),
                                  onPressed: () {
                                    board = [
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      ""
                                    ];
                                    currentPlayer = "X";
                                    moves = 0;
                                    oWin = 0;
                                    xWin = 0;
                                    setState(() {});
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Center(child: Text("No")),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                  },
                  icon: const Icon(
                    Icons.refresh,
                    size: 30,
                  )),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(33, 33, 33, 100),
        body: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Payer X",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Main",
                          color: Colors.white),
                    ),
                    Text(
                      xWin.toString(),
                      style: const TextStyle(
                          fontSize: 30,
                          fontFamily: "Main",
                          color: Colors.white),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Payer O",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Main",
                          color: Colors.white),
                    ),
                    Text(
                      oWin.toString(),
                      style: const TextStyle(
                          fontSize: 30,
                          fontFamily: "Main",
                          color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.46,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return OutlinedButton(
                  onPressed: () {
                    if (board[index] == "") {
                      board[index] = currentPlayer;
                      currentPlayer = (currentPlayer == "X") ? "O" : "X";
                      moves++;
                      setState(() {});
                      if (checkWinner("X")) {
                        showDialog(
                            context: context,
                            builder: (_) => showWinDialog("X"),
                            barrierDismissible: false);
                        xWin++;
                        setState(() {});
                      } else if (checkWinner("O")) {
                        showDialog(
                            context: context,
                            builder: (_) => showWinDialog("O"),
                            barrierDismissible: false);
                        oWin++;
                        setState(() {});
                      } else if (moves == 9) {
                        showDialog(
                            context: context,
                            builder: (_) => showDrawDialog(),
                            barrierDismissible: false);
                      }
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: const RoundedRectangleBorder()),
                  child: Text(
                    board[index],
                    style: const TextStyle(
                        color: Colors.white, fontSize: 60, fontFamily: "Main"),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text(
                  "Turn of $currentPlayer",
                  style: const TextStyle(
                      fontSize: 20, fontFamily: "Main", color: Colors.white),
                ))),
          )
        ]));
  }
}
