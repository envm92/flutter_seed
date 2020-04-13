import 'package:flutter/material.dart';
import 'package:seed/routes.dart';
import 'package:seed/theme.dart';

void main() {
  runApp(new SeedApp());
}

class SeedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: customTheme,
        routes: Routes.get(),
        home: Routes.getHome()
    );
  }
}