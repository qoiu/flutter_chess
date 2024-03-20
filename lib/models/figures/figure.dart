import 'package:chess/models/board.dart';
import 'package:chess/models/figures/pawn.dart';

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
}

abstract class Figures{

  static Figure whitePawn(Point point) => WhitePawn(point);
  static Figure blackPawn(Point point) => BlackPawn(point);

}
