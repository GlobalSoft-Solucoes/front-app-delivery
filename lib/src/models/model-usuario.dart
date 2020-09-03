import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:front_end_pizzaria/src/framework/components/widget-msg.dart';
import 'package:front_end_pizzaria/src/framework/constantes/Const-Server.dart';
import 'package:front_end_pizzaria/src/framework/crud/crud.dart';
import 'package:front_end_pizzaria/src/framework/functions/validacao.dart';
import 'package:http/http.dart' as http;

class Usuario {
  ValidaCampos valida = ValidaCampos();
  String nome;
  String email;
  String senha;

  Usuario({this.nome, this.email, this.senha});

  cadastrar(BuildContext context) async {
    if (!valida.validaEmail(email)) {
      var mensagem = "Digite corretamente seu e-mail ex.: nome@provedor.com";
      var titulo = "E-mail inválido";
      MsgPopup().mensagemErro(context, mensagem, titulo);
    } else if (!valida.validaSenha(senha)) {
      var mensagem = "A senha deve conter no mínimo 8 caracteres";
      var titulo = "Senha inválida";
      MsgPopup().mensagemErro(context, mensagem, titulo);
    } else if (!valida.validaTextField(this.nome)) {
      var mensagem = 'O campo "nome" deve ser preenchido';
      var titulo = "informação";
      MsgPopup().mensagemErro(context, mensagem, titulo);
    } else {
      var corpo = jsonEncode(toJson());
//==================Teste se ja tem O mesmo e-mail cadastrado ====================
      var resultReq =
          await PostJson().post(urlServidor, routerRecupSenha, corpo);
      if (resultReq == 200) {
//==================Tentativa de cadastro  201 = OK===============================
        if (await PostJson().post(urlServidor, routeUsuario, corpo) == 201) {
          var mensagem = "Usuário cadastrado com sucesso!";
          var titulo = "Informação";
          var router = '/LoginUsuario';
          MsgPopup().mensagemSucesso(context, mensagem, titulo, router);
          //   Navigator.of(context).pushNamed('/LoginUsuario');
        } else {
          var mensagem = "Ocorreu um erro no servidor";
          var titulo = "Informação";
          MsgPopup().mensagemErro(context, mensagem, titulo);
        }
//========================Caso o e-mail ja existir================================

      } else if (resultReq == 400) {
        var titulo = "Informação";
        var mensagem =
            "O e-mail informado já está sendo utilizado por outro usuário. Por favor escolha outra conta de e-mail.";
        MsgPopup().mensagemErro(context, mensagem, titulo);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;
    return data;
  }
}

class ModelLogin {
  String usuario;
  String senha;
  ValidaCampos validou = ValidaCampos();
  MsgPopup msgPopup = MsgPopup();

  ModelLogin({this.usuario, this.senha});

  ModelLogin.fromJson(Map<String, dynamic> json) {
    usuario = json['email'];
    senha = json['senha'];
  }
  void logar(BuildContext context) async {
    if (!validou.validaEmail(this.usuario)) {
      var mensagem =
          "\n E-mail inválido. Preencha-o corretamente ex.: nome@provedor.com";
      var titulo = "Informação";
      msgPopup.mensagemErro(context, mensagem, titulo);
    } else if (!validou.validaSenha(this.senha)) {
      var mensagem = "\n A senha deve conter no mínimo 8 caracteres.";
      var titulo = "Informação";
      msgPopup.mensagemErro(context, mensagem, titulo);
    } else {
      var corpo = jsonEncode(toJson());

      http.Response state = await http.post(
        Uri.encodeFull(urlServidor + routeLogin),
        headers: {"Content-Type": "application/json"},
        body: corpo,
      );
      if (state.statusCode == 200) {
        Navigator.of(context).pushNamed('/MenuPrincipal');
      } else if (state.statusCode == 400) {
        var mensagem = "\n Usuário ou senha incorretos.";
        var titulo = "Erro";
        msgPopup.mensagemErro(context, mensagem, titulo);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['email'] = this.usuario;
    data['senha'] = this.senha;
    return data;
  }
}
