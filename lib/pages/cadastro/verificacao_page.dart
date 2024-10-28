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
    timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
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
        appBar: const AppBarWidget(
          titulo: "Verificação de E-mail",
          logout: true,
          rota: '',
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Center(
                child: Text(
                  'Verifique seu email',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Enviamos um email de confirmação para ${auth.currentUser?.email}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  child: const Text('Reenviar e-mail'),
                  onPressed: () {
                    try {
                      FirebaseAuth.instance.currentUser?.sendEmailVerification();
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
