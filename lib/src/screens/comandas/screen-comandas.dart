import 'package:flutter/material.dart';

class Comandas extends StatefulWidget {
  @override
  _ComandasState createState() => _ComandasState();
}

class _ComandasState extends State<Comandas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Mesa"),
        centerTitle: true,
      ),
    );
  }
}
