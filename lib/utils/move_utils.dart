import 'package:chess/models/board.dart';
import 'package:chess/models/pieces/piece.dart';
import 'package:flutter/material.dart';

abstract class MoveUtils {
  static List<Point> checkLine(Board board, Point point, int ofsX, int ofsY,
      [List<StopAction> stopActions = const [], bool includeStopPoint=false]) {
    List<Point?> list = List.empty(growable: true);
    var i = 0;
    while (true) {
      i++;
      debugPrint("checkLine $i");
      var testPoint =
          board.emptyPoint(point.offset(board, x: ofsX * i, y: ofsY * i));
      if (stopActions
          .map((e) => e.stopAction(board, testPoint))
          .any((element) => element)) {
        if(includeStopPoint){
          list.add(testPoint);
        }
        return list.nonNulls.toList();
      }
      list.add(testPoint);
    }
  }

  static Point? checkLineAttack(Piece piece, Board board, int ofsX, int ofsY) {
    var i = 0;
    while (true) {
      i++;
      var testPoint = piece.point.offset(board, x: ofsX * i, y: ofsY * i);
      if (testPoint == null) return null;
      if (board.pieceAt(testPoint) != null) {
        if (board.enemyPieceAt(piece, testPoint) != null) {
          return testPoint;
        } else {
          return null;
        }
      }
    }
  }
}

abstract class StopAction {
  bool stopAction(Board board, Point? point);

  static StopAction ifEmpty = StopActionIfEmpty();
  static StopAction ifAny = StopActionIfAny();
}

class StopActionIfEmpty extends StopAction {
  @override
  bool stopAction(Board board, Point? point) => board.emptyPoint(point) == null;
}
class StopActionIfAny extends StopAction {
  @override
  bool stopAction(Board board, Point? point) => board.pieceAt(point) == null;
}
