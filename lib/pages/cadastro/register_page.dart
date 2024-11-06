// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/components/bottom_appbar_widget.dart';
import 'package:food_quest/components/my_button.dart';
import 'package:food_quest/components/my_textfield.dart';
import 'package:food_quest/services/usuario_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // controllers
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign in
  void signUserUp() async {
    //circulo loading
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
                color: Color.fromARGB(255, 220, 15, 75)),
          );
        });

    //cadastrar
    try {
      //checar senha == confirmacao
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        UsuarioService usuarioService = UsuarioService();
        usuarioService.setNome(nomeController.text);
        //tirar loading
        Navigator.pop(context);
      } else {
        //tirar loading
        Navigator.pop(context);
        //msg erro
        showErrorMessage("Senhas não coincidem");
      }
    } on FirebaseAuthException catch (e) {
      //tirar loading
      e.stackTrace;
      Navigator.pop(context);

      // popup erro
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(msg),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255,75,75,75 ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                const Image(
                  image: AssetImage('assets/images/logo-FoodQuest.png'),
                  height: 100,
                ),

                const SizedBox(height: 25),

                //texto boas-vindas
                const Text("Vamos criar sua conta!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    )),
                const SizedBox(
                  height: 25,
                ),

                //nome textfield
                MyTextField(
                  controller: nomeController,
                  hintText: "Nome",
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                //user textfield
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                //pass textfield
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //confirm pass textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm password",
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //botao login
                MyButton(onTap: signUserUp, text: "Cadastrar-se"),

                const SizedBox(height: 25),

                //ainda nao cadastrado
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Já tem uma conta?',
                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text("Faça login",
                          style: TextStyle(
                            color: Color.fromRGBO( 255, 215, 90, 1),
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}
