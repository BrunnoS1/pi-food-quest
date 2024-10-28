import 'package:flutter/material.dart';
import 'package:food_quest/pages/cadastro/auth_page.dart';
import 'package:food_quest/pages/home_page.dart';


Map<String, Widget Function(BuildContext context)> rotas = {
  //rota para homepage
  '/home': (context) => const HomePage(),

  // Rota para pagina de login
  '/auth_page' : (context) => const AuthPage(),
};