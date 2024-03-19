// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ffi';

import 'package:chess/models/board.dart';
import 'package:chess/models/figure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chess/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    for (var i = 0; i < 1000; ++i) {
      // debugPrint("char $i = ${String.fromCharCode(i)}");
    }
    debugPrint("letterMap: $lettersMap");
    var p = Point("e2");
    debugPrint("x: ${p.x} - ${p.y}");
    var board = Board(lettersMap);
    debugPrint("board: ${board.points}");
    var whitePawn = Figure.whitePawn(Point("a2"));
    var blackPawn = Figure.blackPawn(Point("b4"));
    var blackPawn2 = Figure.blackPawn(Point("b5"));
    board.figures=[whitePawn,blackPawn, blackPawn2];
    debugPrint("whitePawn available attacks: ${whitePawn.possibleAttacks(board)}");
    debugPrint("whitePawn available moves: ${whitePawn.possibleMoves(board)}");
    debugPrint("blackPawn available attacks: ${blackPawn.possibleAttacks(board)}");
    debugPrint("blackPawn available moves: ${blackPawn.possibleMoves(board)}");
    debugPrint("blackPawn2 available attacks: ${blackPawn2.possibleAttacks(board)}");
    debugPrint("blackPawn2 available moves: ${blackPawn2.possibleMoves(board)}");
    debugPrint("enPassant: ${board.enPassant}");
    var possibleMove = whitePawn.possibleMoves(board)[1];
    debugPrint("moveTo: $possibleMove");
    board.move(whitePawn, possibleMove);
    debugPrint("$whitePawn available attacks: ${whitePawn.possibleAttacks(board)}");
    debugPrint("$whitePawn available moves: ${whitePawn.possibleMoves(board)}");
    debugPrint("$blackPawn available attacks: ${blackPawn.possibleAttacks(board)}");
    debugPrint("$blackPawn available moves: ${blackPawn.possibleMoves(board)}");
    debugPrint("$blackPawn2 available attacks: ${blackPawn2.possibleAttacks(board)}");
    debugPrint("$blackPawn2 available moves: ${blackPawn2.possibleMoves(board)}");
    debugPrint("enPassant: ${board.enPassant}");
  });
}
