import 'package:chess/models/board.dart';

import 'figure.dart';

class King extends Figure {
  @override
  String image = "";

  @override
  Point point;

  @override
  double rewardExp = 2;

  King._(this.point);

  King.black(this.point) : image = "assets/svg/king_b.svg";

  King.white(this.point) : image = "assets/svg/king_w.svg";

  List<Point?> _moves(Board board) =>
      [
        point.offset(board, x: 1, y: 0),
        point.offset(board, x: 1, y: 1),
        point.offset(board, x: 0, y: 1),
        point.offset(board, x: -1, y: 1),
        point.offset(board, x: -1, y: 0),
        point.offset(board, x: -1, y: -1),
        point.offset(board, x: 0, y: -1),
        point.offset(board, x: 1, y: -1),
      ];

  @override
  List<Point> possibleMoves(Board board) =>
      _moves(board)
          .where((element) => board.emptyPoint(element) != null)
          .nonNulls
          .toList();

  @override
  List<Point> possibleAttacks(Board board) =>
      _moves(board)
          .where((element) => board.enemyFigureAt(element) != null)
          .nonNulls
          .toList();
}
