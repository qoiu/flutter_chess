import 'package:chess/models/board.dart';
import 'package:chess/models/board_position.dart';
import 'package:chess/utils/move_utils.dart';

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

  Bishop(this.point,this.image);
  Bishop.black(this.point) : image = "assets/svg/bishop_b.svg";
  Bishop.white(this.point) : image = "assets/svg/bishop_w.svg";

  @override
  List<Point> possibleMoves(BoardPosition boardPosition) {
    List<Point> list = List.empty(growable: true);
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, 1, 1,[StopAction.ifEmpty]));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, 1, -1,[StopAction.ifEmpty]));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, -1, -1,[StopAction.ifEmpty]));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, -1, 1,[StopAction.ifEmpty]));
    return list;
  }

  List<Point> possibleProtection(BoardPosition boardPosition) {
    List<Point> list = List.empty(growable: true);
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, 1, 1,[StopAction.ifEmpty],true));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, 1, -1,[StopAction.ifEmpty],true));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, -1, -1,[StopAction.ifEmpty],true));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, -1, 1,[StopAction.ifEmpty],true));
    return list;
  }

  @override
  List<Point> possibleAttacks(BoardPosition boardPosition) =>[
      MoveUtils.checkLineAttack(this, boardPosition.board, 1, 1),
      MoveUtils.checkLineAttack(this, boardPosition.board, 1, -1),
      MoveUtils.checkLineAttack(this, boardPosition.board, -1, 1),
      MoveUtils.checkLineAttack(this, boardPosition.board, -1, -1),
    ].nonNulls.toList();

  @override
  Piece copy() => Bishop(point,image);


  @override
  List<Point> protectedFields(BoardPosition boardPosition)=>possibleProtection(boardPosition);
}
