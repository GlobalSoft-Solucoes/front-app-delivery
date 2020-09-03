import 'package:flutter/material.dart';

class ButtonRotas extends StatelessWidget {
  final Color corButton;
  final String label;
  final Color labelCor; //Alterado por João Royer
  final String rotaOnPress;
  final bool isAnimation;
  final Icon icon;

  const ButtonRotas(
      {Key key,
      this.icon,
      this.isAnimation,
      this.label,
      this.rotaOnPress,
      this.labelCor, //Alterado por João Royer
      this.corButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(rotaOnPress),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
            color: corButton,
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
