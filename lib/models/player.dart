import 'package:chess/models/boards.dart';

import 'pieces/piece.dart';

class Player{
  int id;

  List<Piece> pieces;

  Player(this.id, this.pieces){
   pieces.forEach((element) {
     element.owner=this;
   });
  }

  Player.white():id=1,pieces=Boards.classicWhitePieces;
  Player.black():id=2,pieces=Boards.classicBlackPieces;

  Player.undefined():id=-1,pieces=[];

  Player copy() => Player(id, pieces.map((e) => e.copy()).toList());

}