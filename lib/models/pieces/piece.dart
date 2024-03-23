import 'package:chess/models/board.dart';
import 'package:chess/models/board_position.dart';
import 'package:chess/models/pieces/pawn.dart';

import '../player.dart';

abstract class Piece {
  int id=0;
  abstract String image;
  abstract Point point;
  abstract double rewardExp;
  abstract PieceType type;
  Player owner = Player.undefined();
  double currentExp = 0;

  List<Point> possibleMoves(BoardPosition boardPosition);

  List<Point> possibleAttacks(BoardPosition boardPosition);

  move(BoardPosition board, Point point){
    this.point = point;
  }

  eat(BoardPosition board, Point point, Piece target) {
    currentExp+=target.rewardExp;
    board.pieces.remove(target);
    move(board, point);
  }

  @override
  String toString()=> "$runtimeType($point)";

  Piece copy();
}

abstract class Pieces{

  static Piece whitePawn(Point point) => WhitePawn(point);
  static Piece blackPawn(Point point) => BlackPawn(point);

}

enum PieceType{
  pawnWhite,pawnBlack,knight,bishop,rook,queen,king;
}