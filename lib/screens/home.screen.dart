import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 400.0,
              child: Image.asset('assets/img/logo.png'),
            ),
            Text('Hello world!')
          ],
        ),
      ),
    );
  }
}