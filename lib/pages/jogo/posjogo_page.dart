import 'package:flutter/material.dart';

class PosJogoPage extends StatelessWidget {
  const PosJogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final (int, int) message =
        ModalRoute.of(context)!.settings.arguments as (int, int);
    debugPrint('message\$1 = ${message.$1} // message\$2 = ${message.$2}');
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Text('Voce acertou ${message.$1} de ${message.$2} perguntas'),
        const SizedBox(
          height: 25,
        ),
        ElevatedButton(
          style: ButtonStyle(
            fixedSize: WidgetStateProperty.all(const Size.fromWidth(150)),
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return const Color.fromARGB(
                      255, 220, 15, 75); // Cor de fundo quando pressionado
                }
                return const Color.fromRGBO(
                    255, 215, 90, 1); // Cor de fundo padrão
              },
            ),
            foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return const Color.fromRGBO(
                      255, 215, 90, 1); // Cor do texto quando pressionado
                }
                return const Color.fromARGB(
                    255, 220, 15, 75); // Cor do texto padrão
              },
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/auth_page');
          },
          child: const Text(
            'Voltar ao início',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    )));
  }
}