import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data.dart';
import '../widgets/chess_tile.dart';

class ChessBoard extends StatefulWidget {
  @override
  _ChessBoardState createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  int x;
  int y;
  int xMove;
  var done = false;

  void move(int x, int y, var matrix) {
    if (matrix[x][y].toString()[0] == 'B' &&
        matrix[x][y].toString()[1] == 'P') {
      setState(() {
        xMove = x - 1;
      });
    } else if (matrix[x][y].toString()[0] == 'W' &&
        matrix[x][y].toString()[1] == 'P') {
      setState(() {
        xMove = x + 1;
      });
    } else {
      setState(() {
        xMove = null;
      });
    }
  }

  void onTapBoard(int k, int l, BuildContext ctx, BoardRepresentation board) {
    setState(() {
      x = k;
      y = l;
      Scaffold.of(ctx).hideCurrentSnackBar();
      if (board.matrix[k][l].toString()[1] == 'P') {
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            action: SnackBarAction(
                label: 'Move',
                onPressed: () {
                  board.movePawnMatrix(x, y);
                  setState(() {
                    xMove = null;
                    x = null;
                    y = null;
                  });
                }),
            duration: Duration(minutes: 5),
            content: Text(
                '${board.columnRepresentation.keys.elementAt(k)}${board.rowRepresentation.keys.elementAt(l)}'),
          ),
        );
      }
      move(x, y, board.matrix);
    });
  }

  @override
  Widget build(BuildContext context) {
    var board = Provider.of<BoardRepresentation>(context);
    int tiles = board.matrix.length;
    if (!done) {
      board.initialSetup();
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
              child: GridView.builder(
                  itemCount: tiles * tiles,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: tiles,
                  ),
                  itemBuilder: (ctx, index) {
                    int k, l = 0;
                    k = (index / tiles).floor();
                    l = (index % tiles);
                    return GestureDetector(
                      onTap: () {
                        onTapBoard(k, l, ctx, board);
                      },
                      child: GridTile(
                        child: ChessTile(
                            board: board,
                            k: k,
                            l: l,
                            x: x,
                            xmove: xMove,
                            y: y,
                            size: size),
                      ),
                    );
                  })),
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
