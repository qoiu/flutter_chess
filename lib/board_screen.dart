import 'dart:math';

import 'package:chess/components/main_button.dart';
import 'package:chess/models/board.dart';
import 'package:chess/models/boards.dart';
import 'package:chess/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'models/pieces/piece.dart';

class BoardScreen extends StatefulWidget {
  final Board? board;

  const BoardScreen({this.board, super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  var size = 40.0;
  Piece? selectedPiece;
  Board? _board;
  bool autoplay = false;

  @override
  void initState() {
    super.initState();
    if (widget.board != null) {
      _board = widget.board!;
    } else {
      _board = Boards.classicChessBoard;
    }
    setState(() {});
  }

  startAutoplay()async{
    if(_board==null)return;
    autoplay=true;
    debugPrint("autoplayStarted");
    while(autoplay){
      if(!_board!.currentPosition.currentPlayer.randomMove(_board!)){
        debugPrint("autoplayFinished");
        autoplay=false;
      }
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Widget boardItem(Board board) {
    var isBlack = false;
    debugPrint("protected screen: ${board.currentPosition.protected.where((element) => element.player.id==1).firstOrNull}");
    debugPrint("protected screen: ${board.currentPosition.protected.where((element) => element.player.id==1).firstOrNull?.protection}");
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
                var piece = board.pieceAt(point);
                var protectionBlack = board.currentPosition.protected.where((element) => element.player.id==1).firstOrNull?.protection.get(point);
                var protectionWhite = board.currentPosition.protected.where((element) => element.player.id==0).firstOrNull?.protection.get(point);
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
                          child: piece != null
                              ? SvgPicture.asset(piece.image,
                                  width: size * 0.7, height: size * 0.7)
                              : null),
                      Container(
                        width: size,
                        height: size,
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.topRight,
                        child: Text(
                            (protectionBlack??0).toString()
                        ),
                      ),
                      Container(
                        width: size,
                        height: size,
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                            (protectionWhite??0).toString()
                        ),
                      )
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
          _board==null?const CircularProgressIndicator():boardItem(_board!),
          const SizedBox(height: 10),
          Row(
            children: [
              MainButton("restart", (){
                autoplay=false;
                _board = Boards.classicChessBoard;
                setState(() {});
              }),
              MainButton("autoPlay", startAutoplay),
            ],
          )
        ],
      ),
    );
  }
}
