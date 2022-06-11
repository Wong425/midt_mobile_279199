import 'package:flutter/material.dart';

void main() => runApp(SubscirbeScreen());

class SubscirbeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Ss World'),
          ),
        ),
      ),
    );
  }
}