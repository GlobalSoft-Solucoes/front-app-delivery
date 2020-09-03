import 'package:flutter/material.dart';
import 'package:front_end_pizzaria/src/screens/login/components/widget-body-login.dart';
import 'package:front_end_pizzaria/src/screens/login/components/widget-image-plano-fundo.dart';

class LoginUsuario extends StatefulWidget {
  @override
  _LoginUsuarioState createState() => _LoginUsuarioState();
}

class _LoginUsuarioState extends State<LoginUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ImagePlanoFundo(),
              BodyUserPassLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
