import 'package:chess/models/board.dart';
import 'package:chess/models/pieces/piece.dart';

class ActionMove{
  final Piece piece;
  final Point point;

  ActionMove(this.piece, this.point);

  @override
  String toString() => "$piece -> $point";
}