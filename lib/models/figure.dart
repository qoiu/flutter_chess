import 'package:chess/models/board.dart';
import 'package:flutter/foundation.dart';

abstract class Figure {
  abstract String image;
  abstract Point point;
  abstract double rewardExp;
  double currentExp = 0;

  List<Point> possibleMoves(Board board);

  List<Point> possibleAttacks(Board board);

  move(Board board, Point point){
    this.point = point;
  }

  eat(Board board, Point point, Figure target) {
    currentExp+=target.rewardExp;
    board.figures.remove(target);
    move(board, point);
  }

  @override
  String toString()=> "$runtimeType($point)";

  static Figure whitePawn(Point point) => WhitePawn(point);
  static Figure blackPawn(Point point) => BlackPawn(point);

}

abstract class Pawn extends Figure{
  int moveNumber = 0;
  int moveDirection = 1;
  @override
  double rewardExp = 1;

  @override
  List<Point> possibleAttacks(Board board) {
    Point? enPassantLeft;
    Point? enPassantRight;
    var left = board.getFigureAt(point.offset(board, x:-1));
    if(left is Pawn){
      if(left.moveNumber==1 && board.enPassant== left){
        enPassantLeft=left.point;
      }
    }
    var right = board.getFigureAt(point.offset(board, x:1));
    if(right is Pawn){
      if(board.enPassant== right){
        enPassantLeft=right.point;
      }
    }
    var list = [
      board.getFigureAt(point.offset(board, x: -1, y: moveDirection))?.point,
      board.getFigureAt(point.offset(board, x: 1, y: moveDirection))?.point,
      enPassantRight, enPassantLeft
    ];
    return list.nonNulls.toList();
  }

  @override
  List<Point> possibleMoves(Board board) {
    var list = List<Point>.empty(growable: true);
    var point1 = point.offset(board,y:moveDirection);
    if(point1!=null && board.getFigureAt(point1)==null){
      list.add(point1);
      var point2 = point.offset(board,y:moveDirection*2);
      if(point2!=null && board.getFigureAt(point2)==null){
        list.add(point2);
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
