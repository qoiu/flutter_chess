import 'package:chess/models/actions/move.dart';
import 'package:chess/models/board.dart';
import 'package:chess/models/boards.dart';
import 'package:chess/utils/extensions.dart';
import 'package:flutter/material.dart';

import 'pieces/piece.dart';

class Player{
  int id;

  List<Piece> pieces;

  Player(this.id, this.pieces){initPieces();}

  void initPieces() {
    pieces.forEach((element) {
       element.owner=this;
    });
  }

  List<ActionMove> getAllMoves(Board board){
   return pieces.map((element) {
      return element.possibleMoves(board.currentPosition).map((e) => ActionMove(element, e));
    }).expand((element) => element).toList();
  }

  List<ActionMove> getAllAttacks(Board board){
   return pieces.map((element) {
      return element.possibleAttacks(board.currentPosition).map((e) => ActionMove(element, e));
    }).expand((element) => element).toList();
  }

  bool randomMove(Board board){
    var attack = getAllAttacks(board).randomOrNull();
    debugPrint("possibleAttack: $attack");
    if(attack!=null){
      board.move(attack.piece, attack.point);
      return true;
    }
    var move = getAllMoves(board).randomOrNull();
    debugPrint("possibleMove: $move");
    if(move!=null){
      board.move(move.piece, move.point);
      return true;
    }
    return false;



  }

  Player.white():id=0,pieces=Boards.classicWhitePieces{initPieces();}
  Player.black():id=1,pieces=Boards.classicBlackPieces{initPieces();}

  Player.undefined():id=-1,pieces=[];

  Player copy() => Player(id, pieces.map((e) => e.copy()).toList());

}