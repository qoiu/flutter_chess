import 'package:chess/models/board.dart';
import 'package:chess/models/pieces/piece.dart';

class ActionEat{
  final Piece piece;
  final Piece target;
  final Point point;

  ActionEat(this.piece, this.target, this.point);
}