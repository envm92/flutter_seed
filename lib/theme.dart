import 'package:flutter/material.dart';

final ThemeData customTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = new ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Roboto'
  );
  return base.copyWith(
    primaryColor: Colors.pinkAccent.shade200,
    accentColor: Colors.yellow.shade600,
  );
}