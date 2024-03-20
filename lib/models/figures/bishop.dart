import 'package:chess/models/board.dart';
import 'package:chess/utils/move_utils.dart';
import 'package:chess/utils/move_utils.dart';
import 'package:chess/utils/move_utils.dart';
import 'package:chess/utils/move_utils.dart';
import 'package:flutter/material.dart';

import 'figure.dart';

class Bishop extends Figure {
  @override
  String image = "";

  @override
  Point point;

  @override
  double rewardExp = 2;

  Bishop._(this.point);
  Bishop.black(this.point) : image = "assets/svg/bishop_b.svg";
  Bishop.white(this.point) : image = "assets/svg/bishop_w.svg";

  @override
  List<Point> possibleMoves(Board board) {
    List<Point> list = List.empty(growable: true);
    list.addAll(MoveUtils.checkLine(board, point, 1, 1));
    list.addAll(MoveUtils.checkLine(board, point, 1, -1));
    list.addAll(MoveUtils.checkLine(board, point, -1, -1));
    list.addAll(MoveUtils.checkLine(board, point, -1, 1));
    return list;
  }

  @override
  List<Point> possibleAttacks(Board board) =>[
      MoveUtils.checkLineAttack(board, point, 1, 1),
      MoveUtils.checkLineAttack(board, point, 1, -1),
      MoveUtils.checkLineAttack(board, point, -1, 1),
      MoveUtils.checkLineAttack(board, point, -1, -1),
    ].nonNulls.toList();
}
