import 'package:flutter/material.dart';
import 'package:food_quest/pages/cadastro/auth_page.dart';
import 'package:food_quest/pages/home_page.dart';
import 'package:food_quest/pages/jogo/pergunta_jogo_page.dart';
import 'package:food_quest/pages/jogo/posjogo_page.dart';
import 'package:food_quest/pages/jogo/ranking_page.dart';
import 'package:food_quest/pages/perguntas/visualiza_pergunta_page.dart';
import 'package:food_quest/pages/perguntas/perguntas_page.dart';


Map<String, Widget Function(BuildContext context)> rotas = {
  //rotas para homepage
  '/home_aluno': (context) => const HomePage(professor: false,),
  '/home_prof': (context) => const HomePage(professor: true,),

  // Rota para pagina de login
  '/auth_page' : (context) => const AuthPage(),

  //Rota pagina das perguntas
  '/perguntas_page' : (context) => const PerguntasPage(),

  //Rota para pagina da pergunta do jogo
  '/jogo_pergunta' : (context) => const PerguntaJogoPage(initialQuestionIndex: 0,),

  //Rota para tela pos jogo
  '/posjogo_page' : (context) => const PosJogoPage(),

  //Rota para a tela de ranking
  '/ranking' : (context) => const RankingPage(),

  //Rota para tela de visualizacao de pergunta
  '/visualizar_pergunta' : (context) => VisualizaPerguntaPage(),
  
};