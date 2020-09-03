import 'package:flutter/material.dart';

class TextFieldCustum extends StatelessWidget {
  final String label;
  final IconData iconn;
  final bool isPassword;
  final TextEditingController controll;

  const TextFieldCustum(
      {Key key, this.isPassword = false, this.label, this.iconn, this.controll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controll,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              32,
            ),
          ),
          fillColor: Colors.amberAccent,
          prefixIcon: Icon(iconn) ?? Icon(Icons.ac_unit),
          labelText: label ?? 'Sem descrição',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        obscureText: isPassword,
      ),
    );
  }
}
