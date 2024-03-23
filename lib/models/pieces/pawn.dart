import 'package:chess/models/board.dart';
import 'package:chess/models/board_position.dart';
import 'package:flutter/cupertino.dart';

import 'piece.dart';

abstract class Pawn extends Piece {
  int moveNumber = 0;
  int moveDirection = 1;
  @override
  double rewardExp = 1;

  @override
  List<Point> possibleAttacks(BoardPosition boardPosition) {
    Point? enPassantLeft;
    Point? enPassantRight;
    var left = _enPassantPiece(boardPosition, -1);
    if (left != null) {
      enPassantLeft = point.offset(boardPosition.board, x: -1, y: moveDirection);
    }
    var right = _enPassantPiece(boardPosition, 1);
    boardPosition.board.enemyPieceAt(this, point.offset(boardPosition.board, x: 1));
    if (right != null) {
      enPassantRight = point.offset(boardPosition.board, x: 1, y: moveDirection);
    }
    var list = [
      boardPosition.board
          .enemyPieceAt(this, point.offset(boardPosition.board, x: -1, y: moveDirection))
          ?.point,
      boardPosition.board
          .enemyPieceAt(this, point.offset(boardPosition.board, x: 1, y: moveDirection))
          ?.point,
      enPassantRight,
      enPassantLeft
    ];
    return list.nonNulls.toList();
  }

  Piece? _enPassantPiece(BoardPosition boardPosition, int offset) {
    var piece = boardPosition.board.enemyPieceAt(this, point.offset(boardPosition.board, x: offset));
    if (boardPosition.enPassant == piece && piece!=null) {
      return piece;
    }
    return null;
  }

  @override
  List<Point> possibleMoves(BoardPosition boardPosition) {
    var list = List<Point>.empty(growable: true);
    var point1 = point.offset(boardPosition.board, y: moveDirection);
    if (point1 != null && boardPosition.board.enemyPieceAt(this, point1) == null) {
      list.add(point1);
      var point2 = point.offset(boardPosition.board, y: moveDirection * 2);
      if (moveNumber == 0 &&
          point2 != null &&
          boardPosition.board.enemyPieceAt(this, point2) == null) {
        list.add(point2);
        debugPrint("enPassant");
      }
    }
    debugPrint("possible moves: $list");
    return list.nonNulls.toList();
  }

  @override
  eat(BoardPosition board, Point point, Piece target) {
    debugPrint("this.point.x ${this.point.x}!= point.x ${this.point.x}");
    return super.eat(board, point, target);
  }

  @override
  move(BoardPosition board, Point point) {
    debugPrint("this.point.x ${this.point.x}!= point.x ${point.x}");
    if (this.point.x != point.x) {
      var left = _enPassantPiece(board, -1);
      var right = _enPassantPiece(board, 1);
      if (left != null) {
        eat(board, point, left);
        return;
      }
      if (right != null) {
        eat(board, point, right);
        return;
      }
    }
    moveNumber += 1;
    if ((point.y - this.point.y).abs() > 1) {
      board.enPassant = this;
    }
    super.move(board, point);
  }
}

class WhitePawn extends Pawn {
  @override
  Point point;
  @override
  PieceType type = PieceType.pawnWhite;

  WhitePawn(this.point) {
    moveDirection = 1;
  }

  @override
  String image = "assets/svg/pawn_w.svg";

  @override
  Piece copy() => WhitePawn(point);

}

class BlackPawn extends Pawn {
  @override
  PieceType type = PieceType.pawnBlack;
  @override
  Point point;

  BlackPawn(this.point) {
    moveDirection = -1;
  }

  @override
  String image = "assets/svg/pawn_b.svg";

  @override
  Piece copy() => BlackPawn(point);
}
