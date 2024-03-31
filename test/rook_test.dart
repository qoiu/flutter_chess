import 'package:chess/models/board.dart';
import 'package:chess/models/board_position.dart';
import 'package:chess/models/pieces/king.dart';
import 'package:chess/models/pieces/pawn.dart';
import 'package:chess/models/pieces/rook.dart';
import 'package:chess/models/player.dart';
import 'package:chess/models/protected_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test rook protected strength", testRookPositionCounter);
}

testRookPositionCounter() {
  var rook = Rook.white(Point("a1"));
  var king = King.white(Point("e1"));
  var player1 = Player(0, [king, rook]);
  var board = Board(lettersMap);
  board.currentPosition = BoardPosition(board, [
    player1,
    Player(1, [BlackPawn(Point("a7"))])
  ]);
  board.currentPosition.init();
  debugPrint("test: ${board.currentPosition}");
  var protected = board.currentPosition.protected
      .where((element) => element.player.id == 0)
      .first;
  debugPrint("protected: ${protected.protection}");
  testProtection(protected,"a1",0);
  testProtection(protected,"a2",1);
  testProtection(protected,"a3",1);
  testProtection(protected,"a4",1);
  testProtection(protected,"a5",1);
  testProtection(protected,"a6",1);
  testProtection(protected,"a7",1);
  testProtection(protected,"a8",0);
  testProtection(protected,"b1",1);
  testProtection(protected,"c1",1);
  testProtection(protected,"d1",2);
  testProtection(protected,"e1",1);
  testProtection(protected,"f1",1);
  testProtection(protected,"g1",0);
  testProtection(protected,"h1",0);
}

testProtection(ProtectedPoints protected, String point, int value){
  test("protected point $point", () => expect(protected.protection[Point(point)], value));
}