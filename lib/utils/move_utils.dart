import 'package:chess/models/board.dart';
import 'package:chess/models/pieces/piece.dart';

abstract class MoveUtils{

  static List<Point> checkLine(Board board, Point point, int ofsX, int ofsY){
    List<Point> list = List.empty(growable: true);
    var i =0;
    while(true){
      i++;
      var testPoint = board.emptyPoint(point.offset(board, x: ofsX*i, y: ofsY*i));
      if(testPoint==null)return list;
      list.add(testPoint);
    }
  }

  static Point? checkLineAttack(Piece piece, Board board, Point point, int ofsX, int ofsY){
    var i =0;
    while(true){
      i++;
      var testPoint = point.offset(board, x: ofsX*i, y: ofsY*i);
      if(testPoint==null)return null;
      if(board.enemyPieceAt(piece, testPoint)!=null)return testPoint;
    }
  }
}