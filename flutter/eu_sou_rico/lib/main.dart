import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff0E47A1),
          title: Text('Eu Sou Rico', style: TextStyle(color: Colors.black)),
        ),
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Center(
            child: Image.asset('assets/rubi.png'),
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
