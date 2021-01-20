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

  final columnRepresentation = {
    'A': 0,
    'B': 1,
    'C': 2,
    'D': 3,
    'E': 4,
    'F': 5,
    'G': 6,
    'H': 7,
  };
  final rowRepresentation = {
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

  void initialSetup() {
    matrix = List.generate(8, (index) => List(8), growable: false);
    matrix[rowRepresentation['1']][columnRepresentation['H']] = 'WK';
    matrix[rowRepresentation['1']][columnRepresentation['A']] = 'WQ';
    matrix[rowRepresentation['2']][columnRepresentation['G']] = 'WP';
    matrix[rowRepresentation['2']][columnRepresentation['H']] = 'WP';
    matrix[rowRepresentation['5']][columnRepresentation['E']] = 'BK';
    matrix[rowRepresentation['4']][columnRepresentation['E']] = 'BP';
    matrix[rowRepresentation['4']][columnRepresentation['F']] = 'BP';
    matrix[rowRepresentation['3']][columnRepresentation['B']] = 'BH';
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
