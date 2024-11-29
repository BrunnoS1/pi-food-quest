import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/components/bottom_appbar_widget.dart';
import 'package:food_quest/components/my_button.dart';
import 'package:food_quest/components/my_textfield.dart';
import 'package:food_quest/pages/cadastro/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in function
  void signUserIn() async {
    // Show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
                color: Color.fromARGB(255, 220, 15, 75)),
          );
        });

    // Attempt sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Dismiss loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Dismiss loading circle
      e.stackTrace;
      Navigator.pop(context);

      // Show error message
      showErrorMessage();
    }
  }

  void showErrorMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Email/senha inválidos"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Adiciona a Logo acima dos campos de texto
                const Image(
                  image: AssetImage('assets/images/logo-FoodQuest.png'),
                  height: 100, // Ajuste o tamanho como necessário
                ),

                const SizedBox(height: 50),  // Espaço entre a logo e o campo de email

                // Email text field
                MyTextField(
                  key: const Key("userfield"),
                  controller: emailController,
                  hintText: "email",
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                // Password text field
                MyTextField(
                  key: const Key("passfield"),
                  controller: passwordController,
                  hintText: "senha",
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // Forget password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Esqueceu a senha?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //botao login
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: MyButton(
                        key: const Key("botaologin"),
                        onTap: signUserIn,
                        text: "Login"),
                  ),
                const SizedBox(height: 25),
          
                // sign up novo usuario
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ainda não cadastrado?',
                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      key: const Key("cadastrese"),
                      onTap: widget.onTap,
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.click, // Define o cursor de mão
                        child: Text(
                          "Cadastre-se agora",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 215, 90, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}
