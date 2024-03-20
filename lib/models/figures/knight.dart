import 'package:chess/models/board.dart';

import 'figure.dart';

class Knight extends Figure{

  @override
  String image = "";

  @override
  Point point;

  @override
  double rewardExp=2;


  Knight._(this.point);

  Knight.black(this.point):image="assets/svg/knight_b.svg";
  Knight.white(this.point):image="assets/svg/knight_w.svg";

  List<Point> _moves(Board board) => [
    point.offset(board, x: 2, y: 1),
    point.offset(board, x: 2, y: -1),
    point.offset(board, x: 1, y: 2),
    point.offset(board, x: -1, y: 2),
    point.offset(board, x: -2, y: 1),
    point.offset(board, x: -2, y: -1),
    point.offset(board, x: -1, y: -2),
    point.offset(board, x: 1, y: -2)
  ].nonNulls.toList();

  @override
  List<Point> possibleMoves(Board board) =>
      _moves(board).map((e) => board.emptyPoint(e)).nonNulls.toList();

  @override
  List<Point> possibleAttacks(Board board) {
    return _moves(board)
        .where((element) => board.enemyFigureAt(element) != null)
        .toList();
  }
}