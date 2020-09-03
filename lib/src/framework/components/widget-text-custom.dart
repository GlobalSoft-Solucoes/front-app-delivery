import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String label;
  final double font;
  final Color cor;

  const TextCustom({Key key, this.label, this.font, this.cor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: font ?? 14,
          color: cor ?? Colors.black,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
