import 'package:flutter/material.dart';
import 'package:front_end_pizzaria/src/screens/cadastro-usuario/screen-cadastro-usuario.dart';
import 'package:front_end_pizzaria/src/screens/comandas/screen-comandas.dart';
import 'package:front_end_pizzaria/src/screens/configuracoes/screen-configuracoes.dart';
import 'package:front_end_pizzaria/src/screens/esqueci-minha-senha/screen-esqueci-minha-senha.dart';
import 'package:front_end_pizzaria/src/screens/login/screen-login.dart.dart';
import 'package:front_end_pizzaria/src/screens/menu-principal/screen-menu-principal.dart';
import 'package:front_end_pizzaria/src/screens/produtos/screen-produtos.dart';

import 'src/screens/menu-principal/screen-menu-principal.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/MenuPrincipal': (context) => MenuPrincipal(),
        '/LoginUsuario': (context) => LoginUsuario(),
        '/CadastroUsuario': (context) => CadastroUsuario(),
        '/EsqueciMinhaSenha': (context) => EsqueciMinhaSenha(),
        '/Configuracoes': (context) => Configuracoes(),
        '/Comandas': (context) => Comandas(),
        '/Produtos': (context) => Produtos(),
      },
      home: MenuPrincipal(),
    ),
  );
}
