import 'package:flutter/material.dart';

Color getColor(DateTime date) {
  Color color;
  switch (date.weekday) {
    case DateTime.monday:
      color = Colors.blueAccent;
      break;
    case DateTime.tuesday:
      color = Colors.black;
      break;
    case DateTime.wednesday:
      color = Colors.white;
      break;
    case DateTime.thursday:
      color = Colors.greenAccent;
      break;
    case DateTime.friday:
      color = Colors.redAccent;
      break;
    case DateTime.saturday:
      color = Colors.pinkAccent;
      break;
    case DateTime.sunday:
      color = Colors.yellowAccent;
      break;
    default:
      color = Colors.grey;
  }
  return color;
}
