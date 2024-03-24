import 'dart:core';

import 'package:chess/models/board_position.dart';
import 'package:chess/models/player.dart';
import 'package:flutter/material.dart';

import 'pieces/piece.dart';

var lettersMap =
    List.generate(26, (index) => String.fromCharCode(97 + index)).asMap();

class Board {
  Map<int, String> letterMap;
  late List<Point> points;
  Piece? selectedPiece;
  late Map<Point, OverlayState> overlay;
  Map<PieceType, List<Point>> transformationPoints = {};
  List<BoardPosition> history = [];
  late BoardPosition currentPosition;

  Board(this.letterMap) {
    points = List.generate(64, (index) {
      var x = index ~/ 8;
      return Point("${letterMap[x]}${index % 8 + 1}");
    });
    debugPrint("create cp");
    currentPosition = BoardPosition(this, [Player.white(), Player.black()]);
    debugPrint("init cp");
    currentPosition.init();
    clearOverlay();
    initTransformation();
  }

  initTransformation() {
    transformationPoints = {
      PieceType.pawnWhite:
          List.generate(8, (index) => Point.fromCoord(index, 8)),
      PieceType.pawnBlack:
          List.generate(8, (index) => Point.fromCoord(index, 1))
    };
  }

  void clearOverlay() {
    overlay = Map.fromIterable(points,
        key: (p) => p, value: (p) => OverlayState.none);
  }

  bool isInBounds(int x, int y) {
    return points.contains(Point.fromCoord(x, y));
  }

  Piece? pieceAt(Point? point, [BoardPosition? boardPosition]) {
    if (point == null) return null;
    return (boardPosition ?? currentPosition)
        .pieces
        .where((element) => element.point == point)
        .firstOrNull;
  }

  Piece? enemyPieceAt(Piece piece, Point? point) {
    if (point == null) return null;
    return getEnemyPiece(
        piece,
        currentPosition.pieces
            .where((element) => element.point == point)
            .firstOrNull);
  }

  Piece? getEnemyPiece(Piece p1, Piece? p2) =>
      p1.owner != p2?.owner ? p2 : null;

  Point? emptyPoint(Point? point) {
    if (point == null) return null;
    return currentPosition.pieces
                .where((element) => element.point == point)
                .firstOrNull ==
            null
        ? point
        : null;
  }

  move(Piece piece, Point point) {
    debugPrint("board: ${currentPosition.toString()}");
    history.add(currentPosition);
    currentPosition = currentPosition.move(piece, point);
  }

  cellTap(int x, int y) {
    var point = Point.fromCoord(x, y);
    var piece = pieceAt(point);
    debugPrint("piece select: $piece");
    debugPrint(
        "piece owner id: ${piece?.owner.id} - current: ${currentPosition.currentPlayerId}");
    if (selectedPiece?.possibleMoves(currentPosition).contains(point) == true ||
        selectedPiece?.possibleAttacks(currentPosition).contains(point) ==
            true) {
      debugPrint("move");
      move(selectedPiece!, point);
    }else{
      if (piece != null && piece.owner.id==currentPosition.currentPlayerId) {
        selectedPiece = piece;
      } else {
        if(selectedPiece!=null){
          selectedPiece = null;
        }
      }
    }
    calculateOverlay(selectedPiece);
  }

  Color getOverlayColor(Point point) {
    switch (overlay[point]) {
      case OverlayState.selected:
        return Colors.blue.withOpacity(0.5);
      case OverlayState.move:
        return Colors.green.withOpacity(0.5);
      case OverlayState.attack:
        return Colors.red.withOpacity(0.5);
      default:
        return Colors.transparent;
    }
  }

  calculateOverlay(Piece? piece) {
    clearOverlay();
    if (piece == null) return;
    overlay[piece.point] = OverlayState.selected;
    piece.possibleMoves(currentPosition).forEach((element) {
      overlay.update(element, (value) => OverlayState.move);
    });
    piece.possibleAttacks(currentPosition).forEach((element) {
      overlay.update(element, (value) => OverlayState.attack);
    });
  }
}

class Point {
  final String pointName;

  Point(this.pointName);

  Point.fromCoord(int x, int y) : pointName = "${lettersMap[x]}$y";

  Point? offset(Board board, {int x = 0, int y = 0}) {
    if (!board.isInBounds(this.x + x, this.y + y)) return null;
    return Point.fromCoord(this.x + x, this.y + y);
  }

  @override
  String toString() => pointName;

  String get fullInfo => "$pointName($x, $y)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => pointName.hashCode;

  int get x {
    return lettersMap.keys.where((element) {
          var value = pointName.replaceAll(RegExp('[0-9]'), '');

          return lettersMap[element] == value;
        }).firstOrNull ??
        -1;
  }

  int get y {
    return int.tryParse(pointName.replaceAll(RegExp('[a-zA-Z]'), '')) ?? -1;
  }
}

enum OverlayState {
  none,
  selected,
  move,
  attack;
}
