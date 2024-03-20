
import 'package:chess/models/board.dart';
import 'package:flutter/cupertino.dart';

import 'figure.dart';

abstract class Pawn extends Figure{
  int moveNumber = 0;
  int moveDirection = 1;
  @override
  double rewardExp = 1;

  @override
  List<Point> possibleAttacks(Board board) {
    Point? enPassantLeft;
    Point? enPassantRight;
    var left = board.enemyFigureAt(point.offset(board, x:-1));
    if(left is Pawn){
      if(board.enPassant== left){
        enPassantLeft=point.offset(board, x: -1, y:moveDirection);
      }
    }
    var right = board.enemyFigureAt(point.offset(board, x:1));
    if(right is Pawn){
      if(board.enPassant== right){
        enPassantRight=point.offset(board, x: 1, y:moveDirection);
      }
    }
    var list = [
      board.enemyFigureAt(point.offset(board, x: -1, y: moveDirection))?.point,
      board.enemyFigureAt(point.offset(board, x: 1, y: moveDirection))?.point,
      enPassantRight, enPassantLeft
    ];
    return list.nonNulls.toList();
  }

  @override
  List<Point> possibleMoves(Board board) {
    var list = List<Point>.empty(growable: true);
    var point1 = point.offset(board,y:moveDirection);
    if(point1!=null && board.enemyFigureAt(point1)==null){
      list.add(point1);
      var point2 = point.offset(board,y:moveDirection*2);
      if(moveNumber==0 && point2!=null && board.enemyFigureAt(point2)==null){
        list.add(point2);
        debugPrint("enPassant");
      }
    }
    debugPrint("possible moves: $list");
    return list.nonNulls.toList();
  }

  @override
  move(Board board, Point point) {
    moveNumber+=1;
    if(point.y-this.point.y>1){
      board.enPassant=this;
    }
    return super.move(board, point);
  }
}

class WhitePawn extends Pawn {
  @override
  Point point;


  WhitePawn(this.point){
    moveDirection=1;
  }

  @override
  String image = "assets/svg/pawn_w.svg";

}


class BlackPawn extends Pawn {
  @override
  Point point;


  BlackPawn(this.point){
    moveDirection=-1;
  }

  @override
  String image = "assets/svg/pawn_b.svg";

}
