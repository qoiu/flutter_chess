import 'package:chess/models/board.dart';
import 'package:chess/models/pieces/bishop.dart';
import 'package:chess/models/pieces/knight.dart';
import 'package:chess/models/pieces/queen.dart';
import 'package:chess/models/pieces/rook.dart';

import 'pieces/king.dart';
import 'pieces/piece.dart';

abstract class Boards {
  static Board get classicChessBoard {
    var board = Board(lettersMap);
    // board.currentPosition = BoardPosition(board,[Player.white(),Player.black()]);
    return board;
  }

  static List<Piece> get classicWhitePieces {
    List<Piece> list = [
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
        8, (index) => Pieces.whitePawn(Point.fromCoord(index, 2))));
    return list;
  }

  static List<Piece> get classicBlackPieces {
    List<Piece> list = [
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
        8, (index) => Pieces.blackPawn(Point.fromCoord(index, 7))));
    return list;
  }
}
