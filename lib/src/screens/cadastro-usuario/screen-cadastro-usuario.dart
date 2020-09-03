import 'package:flutter/material.dart';

import 'package:front_end_pizzaria/src/framework/components/widget-button.dart';
import 'package:front_end_pizzaria/src/framework/components/widget-msg.dart';

import 'package:front_end_pizzaria/src/framework/components/widget-text-custom.dart';
import 'package:front_end_pizzaria/src/framework/components/widget-text-field.dart';
import 'package:front_end_pizzaria/src/models/model-usuario.dart';

class CadastroUsuario extends StatefulWidget {
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  Usuario usuario = Usuario();
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerConfSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          label: 'Cadastro de usuário',
          font: 20,
          cor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextCustom(
                label: 'Preencha todos os campos',
                font: 16,
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldCustum(
                iconn: Icons.account_circle,
                label: 'Nome completo:',
                controll: _controllerNome,
              ),
              TextFieldCustum(
                iconn: Icons.email,
                label: 'E-mail:',
                controll: _controllerEmail,
              ),
              TextFieldCustum(
                iconn: Icons.vpn_key,
                label: 'Senha:',
                isPassword: true,
                controll: _controllerSenha,
              ),
              TextFieldCustum(
                iconn: Icons.vpn_key,
                label: 'Confirmar senha:',
                isPassword: true,
                controll: _controllerConfSenha,
              ),
              SizedBox(
                height: 40,
              ),
              ButtonCustom(
                label: 'Cadastrar',
                cor: Colors.green,
                labelCor: Colors.white,
                funOnTap: () {
                  if (_controllerSenha.text == _controllerConfSenha.text) {
                    usuario.email = _controllerEmail.text;
                    usuario.senha = _controllerSenha.text;
                    usuario.nome = _controllerNome.text;
                    usuario.cadastrar(context);
                  } else {
                    var titulo = "Informação";
                    var mensagem = "As senhas informadas não coincidem";
                    MsgPopup().mensagemErro(context, mensagem, titulo);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
