import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/components/appbar_widget.dart';
import 'package:food_quest/services/usuario_service.dart';

class VerificacaoPage extends StatefulWidget {
  const VerificacaoPage({super.key});

  @override
  State<VerificacaoPage> createState() => _VerificacaoPageState();
}

class _VerificacaoPageState extends State<VerificacaoPage> {
  final auth = FirebaseAuth.instance;
  bool isEmailVerified = false;
  Timer? timer;
  UsuarioService usuarioService = UsuarioService();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    bool emailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (emailVerified) {
      setState(() {
        isEmailVerified = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email verificado com sucesso!")),
      );

      timer?.cancel();
      Navigator.pushNamed(context, '/auth_page');
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 75, 75, 75),
        appBar: const AppBarWidget(
          titulo: "Verificação de E-mail",
          logout: true,
          rota: '',
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 120),
              const Center(
                child: Text(
                  'Verifique o seu email',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    style:const TextStyle(color: Color.fromARGB(255, 255, 215, 90)),
                    'Enviamos um email de confirmação para ${auth.currentUser?.email}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 220, 15, 75))),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 220, 15, 75)),
                  // ( Color.fromARGB(255, 255, 215, 90)),
                  child: const Text(style:TextStyle(color: Color.fromARGB(255,255,215,90), fontWeight: FontWeight.bold),'Reenviar e-mail'),
                  
                  onPressed: () {
                    try {
                      FirebaseAuth.instance.currentUser
                          ?.sendEmailVerification();
                    } catch (e) {
                      debugPrint('$e');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
