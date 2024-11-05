import 'package:flutter/material.dart';
import 'package:food_quest/pages/cadastro/auth_page.dart';
import 'package:food_quest/pages/home_page.dart';
import 'package:food_quest/pages/perguntas/perguntas_page.dart';


Map<String, Widget Function(BuildContext context)> rotas = {
  //rotas para homepage
  '/home_aluno': (context) => const HomePage(professor: false,),
  '/home_prof': (context) => const HomePage(professor: true,),

  // Rota para pagina de login
  '/auth_page' : (context) => const AuthPage(),

  //Rota pagina das perguntas
  '/perguntas_page' : (context) => const PerguntasPage(),
};