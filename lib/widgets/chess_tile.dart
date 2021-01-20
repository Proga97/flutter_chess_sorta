import 'package:flutter/material.dart';
import '../data/data.dart';

class ChessTile extends StatelessWidget {
  const ChessTile({
    Key key,
    @required this.board,
    @required this.k,
    @required this.l,
    @required this.x,
    @required this.xmove,
    @required this.y,
    @required this.size,
  }) : super(key: key);

  final BoardRepresentation board;
  final int k;
  final int l;
  final int x;
  final int xmove;
  final int y;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (board.matrix[k][l] != null)
            Center(
                child: Text(
              board.matrix[k][l],
              style: TextStyle(
                  fontSize: 16,
                  color: board.matrix[k][l].toString()[0] == 'B'
                      ? Colors.black
                      : Colors.white),
            )),
          Text(
              '${board.columnRepresentation.keys.elementAt(l)}${board.rowRepresentation.keys.elementAt(k)}',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 10,
              )),
        ],
      ),
      decoration: BoxDecoration(
          color: (k % 2) == (l % 2) ? Colors.grey : Colors.blue,
          border: Border.all(
              color: (x == k || xmove == k) && (y == l)
                  ? Colors.white
                  : Colors.black,
              width: 1)),
      // color: Colors.black,
      height: size / 8,
      width: size / 8,
    );
  }
}
