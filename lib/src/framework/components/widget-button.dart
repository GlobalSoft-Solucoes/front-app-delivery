import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String label;
  final Color labelCor; // Alterado por João Royer
  final Function funOnTap;
  final Color cor;

  const ButtonCustom(
      {Key key, this.label, this.funOnTap, this.cor, this.labelCor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: funOnTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
            color: cor ?? Colors.red,
            borderRadius: BorderRadius.circular(
              32,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: labelCor ?? Colors.black, //Alterado por João Royer
              ),
            ),
          ),
        ),
      ),
    );
  }
}
