import 'package:flutter/material.dart';

Color getColorName(String? colorName) {
  final colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'yellow': Colors.yellow,
    'green': Colors.green,
    'black': Colors.black,
    'brown': Colors.brown,
    'purple': Colors.purple,
    'gray': Colors.grey,
    'white': Colors.white,
    'pink': Colors.pink,
    'orange': Colors.orange,
    'indigo': Colors.indigo,
    'cyan': Colors.cyan,
    'teal': Colors.teal,
  };

  final lowercaseColor = colorName?.toLowerCase();
  return colorMap[lowercaseColor] ?? Colors.indigo;
}
