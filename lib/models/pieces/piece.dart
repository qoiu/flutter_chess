import 'package:chess/models/board.dart';
import 'package:chess/models/board_position.dart';
import 'package:chess/models/pieces/bishop.dart';
import 'package:chess/models/pieces/king.dart';
import 'package:chess/models/pieces/knight.dart';
import 'package:chess/models/pieces/pawn.dart';
import 'package:chess/models/pieces/queen.dart';
import 'package:chess/models/pieces/rook.dart';

import '../player.dart';

abstract class Piece {
  abstract String image;
  abstract Point point;
  abstract double rewardExp;
  abstract PieceType type;

  bool moved = false;
  Player owner = Player.undefined();
  double currentExp = 0;

  List<Point> possibleMoves(BoardPosition boardPosition);

  List<Point> possibleAttacks(BoardPosition boardPosition);

  List<Point> protectedFields(BoardPosition boardPosition);

  move(BoardPosition board, Point point){
    this.point = point;
    moved = true;
  }

  eat(BoardPosition board, Point point, Piece target) {
    currentExp+=target.rewardExp;
    board.players.firstWhere((element) => element.id==target.owner.id).pieces.remove(target);
    move(board, point);
  }

  @override
  String toString()=> "$runtimeType($point)";

  Piece copy();



  /**like pa1*/
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Piece &&
          runtimeType == other.runtimeType &&
          point == other.point &&
          owner.id == other.owner.id &&
          type == other.type;

  @override
  int get hashCode => point.hashCode ^ type.hashCode;

  String toStringNameForSave()=>"${type.shortName}$point@${moved.toString().substring(0,1)}";

  static Piece buildFromData(String data, int playerId){
    PieceType type = PieceType.fromString(data.substring(0,1));
    Point point = Point(data.substring(1,data.length));
    switch(type){
      case PieceType.pawnWhite: return playerId==0?WhitePawn(point):BlackPawn(point);
      case PieceType.pawnBlack: return playerId==0?WhitePawn(point):BlackPawn(point);
      case PieceType.knight: return playerId==0?Knight.white(point):Knight.black(point);
      case PieceType.bishop: return playerId==0?Bishop.white(point):Bishop.black(point);
      case PieceType.rook: return playerId==0?Rook.white(point):Rook.black(point);
      case PieceType.queen: return playerId==0?Queen.white(point):Queen.black(point);
      case PieceType.king: return playerId==0?King.white(point):King.black(point);
    }
  }
}

abstract class Pieces{

  static Piece whitePawn(Point point) => WhitePawn(point);
  static Piece blackPawn(Point point) => BlackPawn(point);

}

enum PieceType{

  pawnWhite("p"),pawnBlack("p"),knight("k"),bishop("B"),rook("R"),queen("Q"),king("K");

  final String shortName;
  const PieceType(this.shortName);

  static PieceType fromString(String type){
    return PieceType.values.firstWhere((element) => element.shortName==type);
  }

}