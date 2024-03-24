import 'package:chess/models/board.dart';
import 'package:chess/models/board_position.dart';
import 'package:chess/models/player.dart';
import 'package:chess/utils/extensions.dart';
import 'package:flutter/cupertino.dart';

class ProtectedPoints{
  Player player;
  BoardPosition  boardPosition;

  ProtectedPoints(this.player, this.boardPosition){
   initProtectedStrength();
   debugPrint("protected $player {$boardPosition}");
  }

  Map<Point,int> protection={};

  initProtectedStrength(){
    protection = { for (var e in boardPosition.board.points) e : 0 };
    debugPrint("protection: $protection");
    player.pieces.expand((element) => element.protectedFields(boardPosition)).forEach((point) {
      debugPrint("${protection[point]}");
      protection.incrementIfExist(point);
    });
    debugPrint("protection: $protection");
  }
}