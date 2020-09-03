import 'package:front_end_pizzaria/src/framework/components/widget-msg.dart';
import 'package:front_end_pizzaria/src/framework/constantes/Const-Server.dart';
import 'package:front_end_pizzaria/src/framework/crud/crud.dart';
import 'package:front_end_pizzaria/src/framework/functions/validacao.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Email {
  String _username;
  var smtpServer;

  Email(String username, String password) {
    _username = username;
    smtpServer = gmail(_username, password);
  }

  //Envia um email para o destinatário, contendo a mensagem com o código
  Future<bool> sendMessage(
      String mensagem, String destinatario, String assunto) async {
    //Configurar a mensagem
    final message = Message()
      ..from = Address(_username, 'GlobalSoft_ST')
      ..recipients.add(destinatario)
      ..subject = assunto
      ..text = mensagem;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}

class RecuperaSenha {
  TextEditingController controllerInfoEmail = TextEditingController();
  TextEditingController controllerCodigoEnviadoEmail = TextEditingController();
  TextEditingController controllerNovaSenha = TextEditingController();
  TextEditingController controllerConfNovaSenha = TextEditingController();
  String msgAvisoAlterarSenha;
  String mensagemErro = "";
  BuildContext context;

  // ================== ENVIA O E-MAIL PARA RECUPERAÇÃO DE SENHA ==================
  String emailUsuario = '';
  String senhaUsuario = '';

  var email = Email('globalsoftsolucoes.tec@gmail.com', 'GlobalSoft.dev@st');
  void _sendEmail() async {
    await email.sendMessage(
        "Olá! Parece que você esqueceu sua senha. \n\n"
                "Seu código de verificação para alteração de senha é:  " +
            senhaUsuario,
        emailUsuario,
        'Boa Brasa Grill - Recuperação de senha');
  }

  // =========== GERAR UMA SENHA RANDOMICA PARA ENVIAR AO E-MAIL DE RECUPERAÇÃO ============
  gerarSenha() {
    var _random = Random.secure();
    var random = List<int>.generate(4, (i) => _random.nextInt(256));
    var verificador = base64Url.encode(random);
    verificador = verificador
        .replaceAll('+', '')
        .replaceAll('-', '')
        .replaceAll('/', '')
        .replaceAll('', '')
        .replaceAll(' ', '')
        .replaceAll('=', '');

    return verificador.trim();
  }

// ======= VERIFICA SE O CÓDIGO INFORMADO É IGUAL AO CÓDIGO ENVIADO NO E-MAIL =========
  verificaCodigoEnviadoNoEmail() {
    if (senhaUsuario == controllerCodigoEnviadoEmail.text) {
      Navigator.of(context).pop();
      _codigoVerificacaoValido();
    } else {
      Navigator.of(context).pop();
      _codigoVerificacaoInvalido();
      controllerCodigoEnviadoEmail.text = '';
    }
  }

  // =========  TELA PARA O USUÁRIO INSERIR O CÓDIGO RECEBIDO NO E-MAIL PARA A RECUPERAÇÃO DE SENHA ===========
  inserirCodigoRecebino() {
    controllerCodigoEnviadoEmail.text = '';
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Digite o código enviado no seu e-mail',
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          // ======= Email =========
          actions: <Widget>[
            new Container(
              alignment: Alignment(0, 0),
              width: 450,
              child: TextField(
                controller: controllerCodigoEnviadoEmail,
                style: new TextStyle(
                  fontSize: 18,
                ),
                decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.code),
                  labelText: 'Código:',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
              ),
            ),
            // ========== Botões ==========
            new Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 100),
                ),
                Container(
                  child: new FloatingActionButton.extended(
                    backgroundColor: Colors.red,
                    label: new Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 23),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  padding: EdgeInsets.only(top: 20, left: 5),
                ),
                Container(
                  child: new FloatingActionButton.extended(
                    backgroundColor: Colors.green,
                    label: Text(
                      'Continuar',
                      style: new TextStyle(fontSize: 23),
                    ),
                    onPressed: () {
                      // Navigator.of(context).pop();
                      verificaCodigoEnviadoNoEmail();
                    },
                  ),
                  padding: EdgeInsets.only(left: 20, top: 20),
                  width: 165,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // ============ POPUP DISPARADO CASO ALGUM ERRO ACONTEÇA AO TENTAR ALTERAR A SENHA ============
  popupValidaCampos() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(''),
        content: new Text(
          msgAvisoAlterarSenha,
          style: TextStyle(
            fontSize: 21,
            color: Colors.red[800],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Ok, Entendi!',
              style: new TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  // ======== MENSAGEM DISPARADA CASO O USUÁRIO DIGITAR INCORRETAMENTE O CÓDIGO RECEBIDO =========
  msgSenhaAlterada() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(''),
        content: new Text(
          'Sua senha foi alterada com sucesso!',
          style: TextStyle(
            fontSize: 21,
            color: Colors.green[900],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Legal!',
              style: new TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/Home');
            },
          )
        ],
      ),
    );
  }

  // ======= VALIDAÇÃO DOS CAMPOS PARA A NOVA SENHA =========

  _validarCamposNovaSenha() {
    String novaSenha = controllerNovaSenha.text;
    String confSenha = controllerConfNovaSenha.text;
    if (novaSenha.length >= 8) {
      if (confSenha == novaSenha) {
        if (ValidaCampos().validaSenha(novaSenha)) {
          edicaoSenhaUsuario();
        }
      } else {
        // setState(
        //   () {
        //     msgAvisoAlterarSenha = "As senhas não coincidem. Verifique!";
        //     popupValidaCampos(_validarCamposNovaSenha());
        //   },
        // );
      }
    } else {
      // setState(
      //   () {
      //     msgAvisoAlterarSenha = "A senha precisa ter mais que 8 caracteres.";
      //     popupValidaCampos(_validarCamposNovaSenha());
      //   },
      // );
    }
  }

  // ======== TELA PARA O USUÁRIO CRIAR UMA NOVA SENHA ==========
  _codigoVerificacaoValido() {
    controllerConfNovaSenha.text = '';
    controllerNovaSenha.text = '';

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Agora, crie uma nova senha para seu login:',
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          // ======= Email =========
          actions: <Widget>[
            new Container(
              padding: EdgeInsets.only(
                top: 0,
              ),
              width: 450,
              child: TextField(
                controller: controllerNovaSenha,
                obscureText: true,
                style: new TextStyle(
                  fontSize: 18,
                ),
                decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.code),
                  labelText: 'Nova senha:',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
              ),
            ),
            new Container(
              // alignment: Alignment(0, 0),
              padding: EdgeInsets.only(top: 15, bottom: 0),
              width: 450,
              child: TextField(
                controller: controllerConfNovaSenha,
                obscureText: true,
                style: new TextStyle(
                  fontSize: 18,
                ),
                decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.code),
                  labelText: 'Confirmar senha:',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
              ),
            ),
            // ========== Botões ==========
            new Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 80),
                ),
                Container(
                  child: new FloatingActionButton.extended(
                    backgroundColor: Colors.red,
                    label: new Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 23),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  padding: EdgeInsets.only(top: 10, left: 5),
                ),
                Container(
                  child: new FloatingActionButton.extended(
                    backgroundColor: Colors.green,
                    label: Text(
                      'Salvar',
                      style: new TextStyle(fontSize: 23),
                    ),
                    onPressed: () {
                      // Navigator.of(context).pop();
                      _validarCamposNovaSenha();
                      // verificaCodigoEnviadoNoEmail();
                    },
                  ),
                  padding: EdgeInsets.only(top: 10, left: 20),
                  width: 165,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // ======== MENSAGEM DISPARADA CASO O USUÁRIO DIGITAR INCORRETAMENTE O CÓDIGO RECEBIDO =========
  _codigoVerificacaoInvalido() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return new CupertinoAlertDialog(
          title: Text('Aviso'),
          content: Text(
            'O código informado não coincide com o código que enviamos ao seu e-mail. Verifique!',
            style: new TextStyle(
                // padding: EdgeInsets.only(top: 20),
                fontSize: 17,
                fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok, Entendi!',
                style: new TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                inserirCodigoRecebino();
              },
            )
          ],
        );
      },
    );
  }

  // ================== MENSAGEM DE CONFIRMAÇÃO DO E-MAIL ENVIADO ===============
  _emailEnviado() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Aviso"),
        content: new Text(
          "\n Verifique seu e-mail, enviamos um e-mail com um código para recuperação da sua senha.",
          style: TextStyle(
              fontSize: 19, color: Colors.green, fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Beleza!',
              style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              inserirCodigoRecebino();
            },
          )
        ],
      ),
    );
  }

// =============== CASO O E-MAIL COM SENHA NÃO SEJA ENVIADO =============
  _emailNaoEnviado() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Aviso"),
        content: new Text(
          "\n Não foi possível enviar o \n e-mail para recuperação da senha.\n\n"
          "Verifique o e-mail informado e tente novamente.",
          style: TextStyle(
              fontSize: 18, color: Colors.red, fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  // ===========  VALIDAÇÃO PARA VER SE O E-MAIL JÁ ESTÁ CADASTRADO =============
  _verificaSeEmailInseridoExiste() async {
    var email = jsonEncode({'email': controllerInfoEmail.text});
    if (ValidaCampos().validaEmail(email)) {
      var result = await http.post(
          Uri.encodeFull(urlServidor + routerRecupSenha),
          headers: {"Content-Type": "application/json"},
          body: email);
      print(result.statusCode);

      if (result.statusCode == 200) {
        // Se o e-mail digitado não existir no banco
        _emailNaoEnviado();
      } else if (result.statusCode == 400) {
        // se o email digitado Existir no banco de dados
        emailUsuario = controllerInfoEmail.text.trim();
        senhaUsuario = gerarSenha() as String;
        _emailEnviado(); // Mensagem de confirmção do e-mail enviado
        _sendEmail(); // Função que faz o envio do e-mail
      } else {
        var mensagem = "Ocorreu um erro no servidor!";
        var titulo = "Erro!";
        emailNaoEnviado(mensagem, titulo);

        // emailUsuario = controllerInfoEmail.text.trim();
        // senhaUsuario = gerarSenha() as String;
        // _emailEnviado(); // Mensagem de confirmção do e-mail enviado
        // _sendEmail();
      }
    } else {
      var mensagem = "O e-mail está inválido! Ex.: nome@provedor.com";
      var titulo = "E-mail inválido";
      MsgPopup().mensagemErro(context, mensagem, titulo);
    }
  }

// ================== MENSAGEM DE CONFIRMAÇÃO DO E-MAIL ENVIADO ===============
  emailEnviado() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Aviso"),
        content: new Text(
          "\n Verifique seu e-mail, enviamos um e-mail com um código para recuperação da sua senha.",
          style: TextStyle(
              fontSize: 19, color: Colors.green, fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Beleza!',
              style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              inserirCodigoRecebino();
            },
          )
        ],
      ),
    );
  }

// =============== CASO O E-MAIL COM SENHA NÃO SEJA ENVIADO =============
  emailNaoEnviado(mensagem, titulo) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => new CupertinoAlertDialog(
        title: new Text(titulo),
        content: new Text(
          mensagem,
          style: TextStyle(
              fontSize: 18, color: Colors.red, fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  // =========  TELA PARA O USUÁRIO INSERIR O E-MAIL PARA SER ENVIADA A SENHA DE RECUPERAÇÃO =============
  inserirEmailEnvio(BuildContext context) {
    controllerInfoEmail.text = '';
    this.context = context;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Digite seu e-mail cadastrado',
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          // ======= Email =========
          actions: <Widget>[
            new Container(
              alignment: Alignment(0, 0),
              width: 450,
              child: TextField(
                controller: controllerInfoEmail,
                style: new TextStyle(
                  fontSize: 18,
                ),
                decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.email),
                  labelText: 'E-mail:',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
              ),
            ),
            // ===== Botões ======
            new Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 100),
                ),
                Container(
                  child: new FloatingActionButton.extended(
                    backgroundColor: Colors.red,
                    label: new Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 23),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  padding: EdgeInsets.only(top: 20, left: 5),
                ),
                Container(
                  child: new FloatingActionButton.extended(
                    backgroundColor: Colors.green,
                    label: Text(
                      'Continuar',
                      style: new TextStyle(fontSize: 23),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _verificaSeEmailInseridoExiste();
                    },
                  ),
                  padding: EdgeInsets.only(left: 20, top: 20),
                  width: 165,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // ============= JSON PARA EDIÇÃO DA SENHA NO BANCO DE DADOS ================
  edicaoSenhaUsuario() async {
    String email = controllerInfoEmail.text.toLowerCase();
    var corpo = jsonEncode(
      {'senha': controllerNovaSenha.text},
    );

    var result = await PutJson()
        .put(urlServidor, routerUpdateFuncionario, corpo, email.toString());
    print(result);
    if (result == 201) {
      Navigator.of(context).pop();
      msgSenhaAlterada();
    }
  }
}
