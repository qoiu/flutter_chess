import 'package:chess/models/board.dart';
import 'package:chess/models/board_position.dart';

import 'piece.dart';

class Knight extends Piece{

  @override
  String image = "";

  @override
  Point point;

  @override
  double rewardExp=2;

  @override
  PieceType type = PieceType.knight;

  Knight(this.point, this.image);

  Knight.black(this.point):image="assets/svg/knight_b.svg";
  Knight.white(this.point):image="assets/svg/knight_w.svg";

  List<Point> _moves(BoardPosition boardPosition) => [
    point.offset(boardPosition.board, x: 2, y: 1),
    point.offset(boardPosition.board, x: 2, y: -1),
    point.offset(boardPosition.board, x: 1, y: 2),
    point.offset(boardPosition.board, x: -1, y: 2),
    point.offset(boardPosition.board, x: -2, y: 1),
    point.offset(boardPosition.board, x: -2, y: -1),
    point.offset(boardPosition.board, x: -1, y: -2),
    point.offset(boardPosition.board, x: 1, y: -2)
  ].nonNulls.toList();

  @override
  List<Point> possibleMoves(BoardPosition boardPosition) =>
      _moves(boardPosition).map((e) => boardPosition.board.emptyPoint(e)).nonNulls.toList();

  @override
  List<Point> possibleAttacks(BoardPosition boardPosition) {
    return _moves(boardPosition)
        .where((element) => boardPosition.board.enemyPieceAt(this,element) != null)
        .toList();
  }



  @override
  Piece copy() => Knight(point,image);

  @override
  List<Point> protectedFields(BoardPosition boardPosition) => _moves(boardPosition);

}