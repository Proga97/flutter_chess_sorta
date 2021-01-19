import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../data/data.dart';

class ChessBoard extends StatefulWidget {
  @override
  _ChessBoardState createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  int x;
  int y;
  int xmove;
  void move(int x, int y, var matrix) {
    if (matrix[x][y].toString()[0] == 'B' &&
        matrix[x][y].toString()[1] == 'P') {
      setState(() {
        xmove = x - 1;
      });
    } else if (matrix[x][y].toString()[0] == 'W' &&
        matrix[x][y].toString()[1] == 'P') {
      setState(() {
        xmove = x + 1;
      });
    } else {
      setState(() {
        xmove = null;
      });
    }
  }

  var done = false;

  @override
  Widget build(BuildContext context) {
    var board = Provider.of<BoardRepresentation>(context);
    if (!done) {
      board.initialsetup();
      done = !done;
    }
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chess'),
      ),
      body: Column(
        children: [
          Container(
            height: size,
            child: ListView.builder(
                itemCount: 8,
                itemBuilder: (ctx, index) {
                  return Container(
                    height: size / 8,
                    width: size / 8,
                    child: ListView.builder(
                        itemCount: 8,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (c, i) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                x = index;
                                y = i;
                                Scaffold.of(c).hideCurrentSnackBar();
                                if (board.matrix[index][i].toString()[1] ==
                                    'P') {
                                  Scaffold.of(c).showSnackBar(
                                    SnackBar(
                                      action: SnackBarAction(
                                          label: 'Move',
                                          onPressed: () {
                                            board.movePawnMatrix(x, y);

                                            setState(() {
                                              xmove = null;
                                              x = null;
                                              y = null;
                                            });
                                          }),
                                      duration: Duration(minutes: 5),
                                      content: Text(
                                          '${board.columnrep.keys.elementAt(i)}${board.rowrep.keys.elementAt(index)}'),
                                    ),
                                  );
                                }

                                move(x, y, board.matrix);
                              });
                            },
                            child: Container(
                              child: Stack(
                                children: [
                                  if (board.matrix[index][i] != null)
                                    Center(
                                        child: Text(
                                      board.matrix[index][i],
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: board.matrix[index][i]
                                                      .toString()[0] ==
                                                  'B'
                                              ? Colors.black
                                              : Colors.white),
                                    )),
                                  Text(
                                      '${board.columnrep.keys.elementAt(i)}${board.rowrep.keys.elementAt(index)}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 10,
                                      )),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: (index % 2) == (i % 2)
                                      ? Colors.grey
                                      : Colors.blue,
                                  border: Border.all(
                                      color: (x == index || xmove == index) &&
                                              (y == i)
                                          ? Colors.white
                                          : Colors.black,
                                      width: 1)),
                              // color: Colors.black,
                              height: size / 8,
                              width: size / 8,
                            ),
                          );
                        }),
                  );
                }),
          ),
          FlatButton(
              color: Colors.blueAccent,
              onPressed: () {
                setState(() {
                  done = false;
                });
              },
              child: Text('Reset'))
        ],
      ),
    );
  }
}
