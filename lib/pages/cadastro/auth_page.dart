import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/pages/cadastro/login_register_page.dart';
import 'package:food_quest/pages/cadastro/verificacao_page.dart';
import 'package:food_quest/pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              //usuario logado
              if (snapshot.hasData) {
                if (snapshot.data!.emailVerified) {
                  return const HomePage();
                } else {
                  return const VerificacaoPage();
                }
              }
              //usuario nao logado
              else {
                return const LoginRegisterPage();
              }
            }));
  }
}
