import 'package:chess/models/board.dart';
import 'package:chess/models/board_position.dart';
import 'package:chess/utils/move_utils.dart';
import 'package:chess/utils/piecesAutoincrement.dart';

import 'piece.dart';
class Bishop extends Piece {
  @override
  String image = "";

  @override
  Point point;

  @override
  double rewardExp = 2;

  @override
  PieceType type = PieceType.bishop;

  Bishop(this.point,this.image) {
    id = piecesLastId++;
  }
  Bishop.black(this.point) : image = "assets/svg/bishop_b.svg";
  Bishop.white(this.point) : image = "assets/svg/bishop_w.svg";

  @override
  List<Point> possibleMoves(BoardPosition boardPosition) {
    List<Point> list = List.empty(growable: true);
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, 1, 1));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, 1, -1));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, -1, -1));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, -1, 1));
    return list;
  }

  @override
  List<Point> possibleAttacks(BoardPosition boardPosition) =>[
      MoveUtils.checkLineAttack(this, boardPosition.board, point, 1, 1),
      MoveUtils.checkLineAttack(this, boardPosition.board, point, 1, -1),
      MoveUtils.checkLineAttack(this, boardPosition.board, point, -1, 1),
      MoveUtils.checkLineAttack(this, boardPosition.board, point, -1, -1),
    ].nonNulls.toList();

  @override
  Piece copy() => Bishop(point,image);

}
