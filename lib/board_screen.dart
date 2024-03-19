import 'package:chess/models/board.dart';
import 'package:chess/models/figure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoardScreen extends StatefulWidget {
  final Board board;

  const BoardScreen(this.board, {super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  var size = 40.0;
  Figure? selectedFigure;

  @override
  Widget build(BuildContext context) {
    size = (MediaQuery.of(context).size.width - 40) / 8;
    var isBlack = false;
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
                  var figure = widget.board.getFigureAt(point);
                  return GestureDetector(
                    onTap: () {
                      debugPrint("x: $x, y: $y");
                      widget.board.cellTap(x, y);
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
                            color: widget.board.getOverlayColor(point),
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
      ),
    );
  }
}
