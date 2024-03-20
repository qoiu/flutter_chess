import 'package:chess/models/board.dart';
import 'package:chess/models/figures/bishop.dart';
import 'package:chess/models/figures/knight.dart';
import 'package:chess/models/figures/queen.dart';
import 'package:chess/models/figures/rook.dart';

import 'figures/figure.dart';
import 'figures/king.dart';

abstract class Boards {
  static Board get classicChessBoard {
    var board = Board(lettersMap);
    board.figures = classicWhiteFigures+classicBlackFigures;
    return board;
  }

  static List<Figure> get classicWhiteFigures {
    List<Figure> list = [
      Rook.white(Point("a1")),
      Knight.white(Point("b1")),
      Bishop.white(Point("c1")),
      Queen.white(Point("d1")),
      King.white(Point("e1")),
      Bishop.white(Point("f1")),
      Knight.white(Point("g1")),
      Rook.white(Point("h1")),
    ];
    list.addAll(List.generate(
        8, (index) => Figures.whitePawn(Point.fromCoord(index, 2))));
    return list;
  }

  static List<Figure> get classicBlackFigures {
    List<Figure> list = [
      Rook.black(Point("a8")),
      Knight.black(Point("b8")),
      Bishop.black(Point("c8")),
      Queen.black(Point("d8")),
      King.black(Point("e8")),
      Bishop.black(Point("f8")),
      Knight.black(Point("g8")),
      Rook.black(Point("h8")),
    ];
    list.addAll(List.generate(
        8, (index) => Figures.blackPawn(Point.fromCoord(index, 7))));
    return list;
  }
}
