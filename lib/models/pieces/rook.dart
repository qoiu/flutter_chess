import 'package:chess/models/board.dart';
import 'package:chess/models/board_position.dart';
import 'package:chess/utils/move_utils.dart';

import 'piece.dart';

class Rook extends Piece {
  @override
  String image = "";

  @override
  Point point;

  @override
  double rewardExp = 2;

  @override
  PieceType type = PieceType.rook;

  Rook(this.point,this.image);
  Rook.black(this.point) : image = "assets/svg/rook_b.svg";
  Rook.white(this.point) : image = "assets/svg/rook_w.svg";

  @override
  List<Point> possibleMoves(BoardPosition boardPosition) {
    List<Point> list = List.empty(growable: true);
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, 0, 1));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, 0, -1));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, -1, 0));
    list.addAll(MoveUtils.checkLine(boardPosition.board, point, 1, 0));
    return list;
  }

  @override
  List<Point> possibleAttacks(BoardPosition boardPosition) =>[
      MoveUtils.checkLineAttack(this, boardPosition.board, point, 0, 1),
      MoveUtils.checkLineAttack(this, boardPosition.board, point, 0, -1),
      MoveUtils.checkLineAttack(this, boardPosition.board, point, -1, 0),
      MoveUtils.checkLineAttack(this, boardPosition.board, point, 1, 0),
    ].nonNulls.toList();

  @override
  Piece copy() => Rook(point,image);

}
