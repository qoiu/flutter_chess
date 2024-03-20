import 'package:chess/models/board.dart';
import 'package:chess/utils/move_utils.dart';
import 'package:chess/utils/move_utils.dart';
import 'package:chess/utils/move_utils.dart';
import 'package:chess/utils/move_utils.dart';
import 'package:flutter/material.dart';

import 'figure.dart';

class Rook extends Figure {
  @override
  String image = "";

  @override
  Point point;

  @override
  double rewardExp = 2;

  Rook._(this.point);
  Rook.black(this.point) : image = "assets/svg/rook_b.svg";
  Rook.white(this.point) : image = "assets/svg/rook_w.svg";

  @override
  List<Point> possibleMoves(Board board) {
    List<Point> list = List.empty(growable: true);
    list.addAll(MoveUtils.checkLine(board, point, 0, 1));
    list.addAll(MoveUtils.checkLine(board, point, 0, -1));
    list.addAll(MoveUtils.checkLine(board, point, -1, 0));
    list.addAll(MoveUtils.checkLine(board, point, 1, 0));
    return list;
  }

  @override
  List<Point> possibleAttacks(Board board) =>[
      MoveUtils.checkLineAttack(board, point, 0, 1),
      MoveUtils.checkLineAttack(board, point, 0, -1),
      MoveUtils.checkLineAttack(board, point, -1, 0),
      MoveUtils.checkLineAttack(board, point, 1, 0),
    ].nonNulls.toList();
}
