
import 'package:chess/models/board.dart';
import 'package:chess/models/figure.dart';

abstract class Boards{

  static Board get classicChessBoard {
    var board = Board(lettersMap);
    var whitePawn = Figure.whitePawn(Point("a2"));
    var blackPawn = Figure.blackPawn(Point("b4"));
    var blackPawn2 = Figure.blackPawn(Point("b5"));
    board.figures=[whitePawn,blackPawn, blackPawn2];
    return board;
  }


}