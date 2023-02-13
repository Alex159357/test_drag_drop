import 'package:flutter/material.dart';

class WidgetModel{
  int id;
  int type;
  double dx;
  double dy;

  WidgetModel({required this.id, required this.type, required this.dx, required this.dy});

  void changeCoordinates({required double dx, required double dy}){
    this.dx = dx;
    this.dy = dy;
  }

}