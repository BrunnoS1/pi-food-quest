import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/components/my_button.dart';
import 'package:food_quest/components/my_textfield.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  void resetPassword(BuildContext context) async {
    try {
      // Simula envio de e-mail para redefinição de senha
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );
      // Exibe mensagem de sucesso
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Email de redefinição enviado!"),
            content: Text("Verifique seu email para redefinir sua senha."),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // Exibe mensagem de erro
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro"),
            content: Text(e.message ?? "Ocorreu um erro. Tente novamente."),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 215, 90, 1),
        title: const Text("Redefinir Senha"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // Logo
                  const Image(
                    image: AssetImage('assets/images/logo-FoodQuest.png'),
                    height: 100, // Ajuste conforme necessário
                  ),

                  const SizedBox(height: 50),

                  // Instruções
                  const Text(
                    "Digite seu email para receber o link de redefinição de senha.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Campo de email
                  MyTextField(
                    controller: emailController,
                    hintText: "Digite seu email",
                    obscureText: false,
                  ),

                  const SizedBox(height: 25),

                  // Botão para redefinir senha
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: MyButton(
                      onTap: () => resetPassword(context),
                      text: "Enviar link",
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Voltar para a tela de login
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Voltar para o login",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 215, 90, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
