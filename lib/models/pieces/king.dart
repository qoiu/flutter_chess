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

  King(this.point, this.image);

  King.black(this.point) : image = "assets/svg/king_b.svg";

  King.white(this.point) : image = "assets/svg/king_w.svg";

  List<Point?> _moves(BoardPosition boardPosition) => [
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
  possibleMoves(BoardPosition boardPosition) {
    var result = _moves(boardPosition)
        .where((element) => boardPosition.board.emptyPoint(element) != null)
        .nonNulls
        .toList();
    result.addAll(possibleCastling(boardPosition));
    return result;
  }

  @override
  protectedFields(BoardPosition boardPosition) => _moves(boardPosition).nonNulls.toList();

  @override
  List<Point> possibleAttacks(BoardPosition boardPosition) =>
      _moves(boardPosition)
          .where((element) =>
              boardPosition.board.enemyPieceAt(this, element) != null)
          .nonNulls
          .toList();

  List<Point> possibleCastling(BoardPosition boardPosition) {
    if (moved) return [];
    List<Point> list = [
      // checkCastling(boardPosition.board, 0, 1)!=null?point.offset(boardPosition.board):null,
      // checkCastling(boardPosition.board, 0, -1),
      // checkCastling(boardPosition.board, 1, 0),
      // checkCastling(boardPosition.board, -1, 0),
    ];

    return list;
  }

  @override
  Piece copy() => King(point, image);

  Point? castlingTargetKing() {
    return null;
  }

  Piece? checkCastling(Board board, int ofsX, int ofsY) {
    var i = 0;
    while (true) {
      i++;
      var testPoint = point.offset(board, x: ofsX * i, y: ofsY * i);
      if (testPoint == null) return null;
      var pieceAt = board.pieceAt(testPoint);
      if (pieceAt != null && pieceAt.type == PieceType.rook) {
        return pieceAt;
      } else {
        return null;
      }
    }
    return null;
  }
}
