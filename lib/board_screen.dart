import 'dart:math';

import 'package:chess/components/main_button.dart';
import 'package:chess/models/board.dart';
import 'package:chess/models/boards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'models/figures/figure.dart';

class BoardScreen extends StatefulWidget {
  final Board? board;

  const BoardScreen({this.board, super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  var size = 40.0;
  Figure? selectedFigure;
  late Board board;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.board != null) {
      board = widget.board!;
    } else {
      board = Boards.classicChessBoard;
    }
  }

  Widget boardItem() {
    var isBlack = false;
    return Column(
      children: [
        for (var y = 8; y > 0; --y) ...{
          Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(8, (x) {
                if (x == 0) {
                  isBlack = !isBlack;
                }
                isBlack = !isBlack;
                var point = Point.fromCoord(x, y);
                var figure = board.enemyFigureAt(point);
                return GestureDetector(
                  onTap: () {
                    debugPrint("x: $x, y: $y");
                    board.cellTap(x, y);
                    setState(() {});
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: size,
                        height: size,
                        color: isBlack ? Colors.black26 : Colors.white38,
                      ),
                      Container(
                          width: size,
                          height: size,
                          color: board.getOverlayColor(point),
                          alignment: Alignment.center,
                          child: figure != null
                              ? SvgPicture.asset(figure.image,
                                  width: size * 0.7, height: size * 0.7)
                              : null)
                    ],
                  ),
                );
              }))
        }
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    size = (min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height)) / 8 - 40;
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          boardItem(),
          const SizedBox(height: 10),
          MainButton("restart", (){
            board = Boards.classicChessBoard;
            setState(() {});
          })
        ],
      ),
    );
  }
}
