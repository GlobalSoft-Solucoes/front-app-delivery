import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MsgPopup {
  mensagemErro(BuildContext context, mensagem, titulo) {
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
        actions: [
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

  mensagemSucesso(BuildContext context, mensagem, titulo, router) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => new CupertinoAlertDialog(
        title: new Text(titulo),
        content: new Text(
          mensagem,
          style: TextStyle(
              fontSize: 19, color: Colors.green, fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Ok",
              style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              if (router == "") {
                Navigator.of(context).pop();
              } else {
                Navigator.pushNamed(context, router);
              }

              //
            },
          )
        ],
      ),
    );
  }

  // Nesta Popup, é disparada uma mensagem informativa para o usuário ficar consciente
  // de algo que aconteceu. É um popup que tem apenas um botão botão "OK"
  msgFeedback(BuildContext context, mensagem, titulo, {Color corMsg}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => new CupertinoAlertDialog(
        title: new Text(titulo),
        content: new Text(
          mensagem,
          style: TextStyle(
              fontSize: 18,
              color: corMsg ?? Colors.black,
              fontWeight: FontWeight.w800),
        ),
        actions: [
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

  // NESTE POPUP, É DISPARADO UMA MENSAGEM QUE QUANDO CONFIRMADA, FAZ UM DIRECIONAMENTO PARA OUTRA ROTA OU CHAMADA DE FUNÇÃO
// para fazer o redirecionamento, é preciso passar como parametro o "onPressed()" que será responsável por conter todas as
// rotas e funções necessárias
  msgDirecionamento(BuildContext context, mensagem, titulo, onPressed(),
      {Color corMsg, txtButton}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => new CupertinoAlertDialog(
        title: new Text(titulo),
        content: new Text(
          mensagem,
          style: TextStyle(
            fontSize: 19,
            color: corMsg ??
                Colors
                    .black, // Caso nenhuma cor for passada como parametro, pega a cor default para a mensagem
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              txtButton ?? "Ok",
              style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              onPressed();
            },
          )
        ],
      ),
    );
  }
}
