import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_quest/components/appbar_widget.dart';
import 'package:food_quest/components/bottom_appbar_widget.dart';

class PosJogoPage extends StatelessWidget {
  const PosJogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Verifica se os argumentos foram passados corretamente
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final (int, int) message = arguments is (int, int)
        ? arguments
        : (0, 0); // Valor padrão caso não sejam passados argumentos válidos

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      appBar: const AppBarWidget(
        titulo: "Resultado Final",
        rota: '/home_aluno', // Atualize conforme necessário
        logout: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Adiciona o ícone com base nos acertos
              Icon(
                message.$1 == 0
                    ? Icons.close // Ícone de reprovação
                    : Icons.emoji_events, // Ícone de vitória
                color: message.$1 == 0 ? Colors.red : Colors.amber,
                size: 100,
              ),
              const SizedBox(height: 20),

              // Texto principal com estilos diferenciados
              Text(
                'Você acertou ${message.$1} de ${message.$2} perguntas!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Botão estilizado
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(const Size(200, 50)),
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return const Color.fromARGB(
                            255, 220, 15, 75); // Cor ao pressionar
                      }
                      return const Color.fromRGBO(
                          255, 215, 90, 1); // Cor padrão
                    },
                  ),
                  foregroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return const Color.fromRGBO(
                            255, 215, 90, 1); // Cor do texto ao pressionar
                      }
                      return const Color.fromARGB(
                          255, 220, 15, 75); // Cor do texto padrão
                    },
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/auth_page');
                },
                child: const Text(
                  'Voltar ao início',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}
