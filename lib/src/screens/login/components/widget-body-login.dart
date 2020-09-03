import 'package:flutter/material.dart';
import 'package:front_end_pizzaria/src/framework/components/widget-button-router.dart';
import 'package:front_end_pizzaria/src/framework/components/widget-button.dart';
import 'package:front_end_pizzaria/src/framework/components/widget-tela-recup-senha.dart';
import 'package:front_end_pizzaria/src/framework/components/widget-text-field.dart';
import 'package:front_end_pizzaria/src/models/model-usuario.dart';

class BodyUserPassLogin extends StatefulWidget {
  @override
  _BodyUserPassLoginState createState() => _BodyUserPassLoginState();
}

class _BodyUserPassLoginState extends State<BodyUserPassLogin> {
  ModelLogin modelLogin = ModelLogin();

  TextEditingController _controllerUsuario = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            TextFieldCustum(
              iconn: Icons.account_circle,
              label: 'Username:',
              controll: _controllerUsuario,
            ),
            TextFieldCustum(
              label: 'Password:',
              iconn: Icons.vpn_key,
              isPassword: true,
              controll: _controllerSenha,
            ),
            ButtonCustom(
              cor: Colors.red,
              funOnTap: () {
                modelLogin.usuario = _controllerUsuario.text;
                modelLogin.senha = _controllerSenha.text;
                modelLogin.logar(context);
                // print(modelLogin.toJson());
              },
              label: 'Conectar',
              labelCor: Colors.white,
            ),
            ButtonRotas(
              rotaOnPress: '/CadastroUsuario',
              corButton: Colors.green,
              label: 'Cadastrar-se',
              // labelCor: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            // TextCustom(
            //   label: 'Esqueci minha senha!!',
            //   font: 20,
            // ),
            new Padding(
              padding: new EdgeInsets.only(
                top: 20,
                left: 90,
              ),
              child: GestureDetector(
                onTap: () {
                  RecuperaSenha().inserirEmailEnvio(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // ButtonRotas(
            //   rotaOnPress: '/Esq_senha',
            //   // corButton: Colors.green,
            //   label: 'sisqueci',
            //   // labelCor: Colors.white,
            // ),
          ],
        ),
      ),
    );
  }
}
