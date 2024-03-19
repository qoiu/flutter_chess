import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'figure.dart';

var lettersMap = List.generate(26, (index) => String.fromCharCode(97+index)).asMap();
class Board{
  Map<int,String> letterMap;
  late List<Point> points;
  List<Figure> figures=[];
  Figure? enPassant;
  Figure? selectedFigure;
  late Map<Point,OverlayState> overlay;

  Board(this.letterMap){
    points = List.generate(64, (index){
      var x = index~/8;
      return Point("${letterMap[x]}${index % 8 + 1}");
    } );
    clearOverlay();
  }

  void clearOverlay() {
    overlay = Map.fromIterable(points, key: (p)=>p, value: (p)=>OverlayState.none);
  }

  bool isInBounds(int x, int y){
    return points.contains(Point.fromCoord(x, y));
}

  Figure? getFigureAt(Point? point){
    if(point==null)return null;
    return figures.where((element) => element.point==point).firstOrNull;
  }

  move(Figure figure, Point point){
    enPassant=null;
    var target=getFigureAt(point);
    if(target==null) {
      figure.move(this, point);
    }else{
      figure.eat(this, point, target);
    }
  }

  cellTap(int x, int y) {
    var point = Point.fromCoord(x, y);
    var figure = getFigureAt(point);
    if(selectedFigure?.possibleMoves(this).contains(point)==true || selectedFigure?.possibleAttacks(this).contains(point)==true){
      debugPrint("move");
      move(selectedFigure!, point);
    }else if(figure!=null){
        selectedFigure = figure;
    }else{
      selectedFigure = null;
    }
    calculateOverlay(selectedFigure);
  }

  Color getOverlayColor(Point point){
    switch(overlay[point]){
      case OverlayState.selected: return Colors.blue.withOpacity(0.5);
      case OverlayState.move: return Colors.green.withOpacity(0.5);
      case OverlayState.attack: return Colors.red.withOpacity(0.5);
      default: return Colors.transparent;
    }
  }

  calculateOverlay(Figure? figure){
    clearOverlay();
    if(figure==null)return;
    overlay[figure.point]=OverlayState.selected;
    figure.possibleMoves(this).forEach((element) {
      overlay.update(element, (value) => OverlayState.move);
    });
    figure.possibleAttacks(this).forEach((element) {
      overlay.update(element, (value) => OverlayState.attack);
    });
  }

}

class Point{
  final String pointName;

  Point(this.pointName);
  Point.fromCoord(int x, int y):pointName="${lettersMap[x]}$y";

  Point? offset(Board board, {int x=0, int y=0}){
    if(!board.isInBounds(this.x+x, this.y+y))return null;
    return Point.fromCoord(this.x+x, this.y+y);
  }


  @override
  String toString() => "$pointName($x, $y)";


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          other.x==x && other.y==y;

  @override
  int get hashCode => pointName.hashCode;

  int get x {
    return  lettersMap.keys.where((element) {
      var value = pointName.replaceAll(RegExp('[0-9]'),'');

      return lettersMap[element]== value;
    }).firstOrNull??-1;
  }

  int get y {
    return int.tryParse(pointName.replaceAll(RegExp('[a-zA-Z]'),''))??-1;
  }


}

enum OverlayState{
  none, selected, move, attack;
}