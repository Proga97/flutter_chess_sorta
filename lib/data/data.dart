import 'package:flutter/material.dart';

class BoardRepresentation with ChangeNotifier {
  final pieces = {
    'king': 'k',
    'queen': 'q',
    'bishop': 'b',
    'knight': 'k',
    'rook': 'r',
    'pawn': 'p',
    'black': 'b',
    'white': 'w',
  };

  final colors = {
    'white': 'w',
    'black': 'b',
  };

  final columnrep = {
    'A': 0,
    'B': 1,
    'C': 2,
    'D': 3,
    'E': 4,
    'F': 5,
    'G': 6,
    'H': 7,
  };
  final rowrep = {
    '1': 0,
    '2': 1,
    '3': 2,
    '4': 3,
    '5': 4,
    '6': 5,
    '7': 6,
    '8': 7,
  };

  var matrix = List.generate(8, (index) => List(8), growable: false);

  void initialsetup() {
    matrix = List.generate(8, (index) => List(8), growable: false);
    matrix[rowrep['1']][columnrep['H']] = 'WK';
    matrix[rowrep['1']][columnrep['A']] = 'WQ';
    matrix[rowrep['2']][columnrep['G']] = 'WP';
    matrix[rowrep['2']][columnrep['H']] = 'WP';
    matrix[rowrep['5']][columnrep['E']] = 'BK';
    matrix[rowrep['4']][columnrep['E']] = 'BP';
    matrix[rowrep['4']][columnrep['F']] = 'BP';
    matrix[rowrep['3']][columnrep['B']] = 'BH';
  }

  void movePawnMatrix(int x, int y) {
    if (matrix[x][y].toString()[0] == 'B' &&
        matrix[x][y].toString()[1] == 'P') {
      if (x > 0) {
        var temp = matrix[x][y];
        matrix[x][y] = null;
        matrix[x - 1][y] = temp;
      }
    } else if (matrix[x][y].toString()[0] == 'W' &&
        matrix[x][y].toString()[1] == 'P') {
      if (x < matrix[x].length - 1) {
        var temp = matrix[x][y];
        matrix[x][y] = null;
        matrix[x + 1][y] = temp;
      }
    }
    notifyListeners();
  }
}
