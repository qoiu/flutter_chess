import 'package:chess/models/board.dart';
import 'package:chess/models/pieces/piece.dart';
import 'package:chess/models/player.dart';
import 'package:chess/models/protected_points.dart';
import 'package:flutter/material.dart';

class BoardPosition{

  int currentPlayerId=0;
  Board board;
  Piece? enPassant;

  BoardPosition(this.board, this.players, {int? currentPlayer}){
    currentPlayerId = currentPlayer??players.first.id;
    debugPrint("protected3: $protected");
  }

  init(){
    protected = players.map((e) => ProtectedPoints(e, this)).toList();
    debugPrint("protected1: $protected");
  }

  List<Player> players=[];
  List<ProtectedPoints> protected = [];
  List<Piece> get pieces=>players.map((e) => e.pieces).expand((element) => element).toList();

  Player get currentPlayer => players.firstWhere((element) => element.id==currentPlayerId);

  BoardPosition.parse(this.board, String data){
    players=[];
    protected = players.map((e) => ProtectedPoints(e, this)).toList();
    debugPrint("protected2: $protected");
  }

  int nextPlayer(){
    int index = players.indexOf(currentPlayer);
    if(index==players.length-1){
      return players[0].id;
    }else{
      return players[index+1].id;
    }
  }

  BoardPosition copy()=>BoardPosition(board, players.map((e) => e.copy()).toList(), currentPlayer: nextPlayer());

    BoardPosition move(Piece piece, Point point){
      var newBoardPosition = copy();
      var selectedPiece = newBoardPosition.board.pieceAt(piece.point, newBoardPosition);
      if(selectedPiece==null){
        throw Exception("copy error");
      }
      var enPassantOld = enPassant;
      var target=newBoardPosition.board.pieceAt(point);
      if(target==null) {
        selectedPiece.move(newBoardPosition, point);
      }else{
        selectedPiece.eat(newBoardPosition, point, target);
      }
      if(enPassantOld==enPassant){
        enPassant=null;
      }
      nextPlayer();
      newBoardPosition.init();
      return newBoardPosition;
    }

    @override
    String toString() {
      var pl = players.map((pl) => "${pl.id}-${pl.pieces.map((piece) => piece.toStringNameForSave()).join(",")}").join("!");
      return "$currentPlayerId|$pl";
    }
  }