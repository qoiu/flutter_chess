import 'package:chess/models/board.dart';
import 'package:chess/models/pieces/piece.dart';
import 'package:chess/models/player.dart';

class BoardPosition{

  Board board;
  Piece? enPassant;
  List<Player> players=[];
  List<Piece> pieces=[];

  BoardPosition(this.board, this.players){
    players.forEach((element) {
      pieces.addAll(element.pieces);
    });
  }

  BoardPosition.parse(this.board, String data){
    players=[];
  }

  BoardPosition copy()=>BoardPosition(board, players.map((e) => e.copy()).toList());

  BoardPosition move(Piece piece, Point point){
    var newBoardPosition = copy();
    var selectedPiece = newBoardPosition.board.pieceAt(piece.point);
    if(selectedPiece==null){
      throw Exception("copy error");
    }
    var enPassantOld = enPassant;
    var target=newBoardPosition.board.enemyPieceAt(selectedPiece, point);
    if(target==null) {
      selectedPiece.move(newBoardPosition, point);
    }else{
      selectedPiece.eat(newBoardPosition, point, target);
    }
    if(enPassantOld==enPassant){
      enPassant=null;
    }
    return newBoardPosition;
  }



}