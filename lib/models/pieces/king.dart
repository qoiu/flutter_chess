import 'package:chess/models/board.dart';
import 'package:chess/models/board_position.dart';

import 'piece.dart';

class King extends Piece {
  @override
  String image = "";

  @override
  Point point;

  @override
  double rewardExp = 2;

  @override
  PieceType type = PieceType.king;

  King(this.point,this.image);

  King.black(this.point) : image = "assets/svg/king_b.svg";

  King.white(this.point) : image = "assets/svg/king_w.svg";

  List<Point?> _moves(BoardPosition boardPosition) =>
      [
        point.offset(boardPosition.board, x: 1, y: 0),
        point.offset(boardPosition.board, x: 1, y: 1),
        point.offset(boardPosition.board, x: 0, y: 1),
        point.offset(boardPosition.board, x: -1, y: 1),
        point.offset(boardPosition.board, x: -1, y: 0),
        point.offset(boardPosition.board, x: -1, y: -1),
        point.offset(boardPosition.board, x: 0, y: -1),
        point.offset(boardPosition.board, x: 1, y: -1),
      ];

  @override
  List<Point> possibleMoves(BoardPosition boardPosition) =>
      _moves(boardPosition)
          .where((element) => boardPosition.board.emptyPoint(element) != null)
          .nonNulls
          .toList();

  @override
  List<Point> possibleAttacks(BoardPosition boardPosition) =>
      _moves(boardPosition)
          .where((element) => boardPosition.board.enemyPieceAt(this,element) != null)
          .nonNulls
          .toList();

  @override
  Piece copy() => King(point,image);

}
