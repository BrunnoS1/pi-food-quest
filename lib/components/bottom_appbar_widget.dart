import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatefulWidget {
  const BottomAppBarWidget({super.key});

  @override
  State<BottomAppBarWidget> createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 100,
      color: const Color.fromARGB(0, 0, 0, 0),
      elevation: 0,
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Espaçamento entre as seções
            children: [
              // Texto "Sobre nós" à esquerda
              Flexible(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: const Color.fromARGB(
                                255, 75, 75, 75), // Cor de fundo da interface
                            title: const Text(
                              "Sobre nós",
                              style: TextStyle(
                                  color: Colors.white), // Cor do texto do título
                            ),
                            content: const Text(
                              "Somos alunos de Ciência da Computação e criamos este jogo didático sobre o sistema "
                              "digestório para tornar o aprendizado mais acessível e divertido. Nossa meta é ajudar estudantes a "
                              "entender melhor o funcionamento do sistema digestório com perguntas interativas e conteúdo "
                              "educativo. Aproveite o jogo e aprenda de forma divertida!",
                              style: TextStyle(
                                  color: Colors.white), // Cor do texto do conteúdo
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Fechar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Sobre nós",
                        style: TextStyle(
                          color: Colors.white, // Cor do texto "Sobre nós"
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Imagens centralizadas no meio da BottomAppBar
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Image.asset(
                        'assets/images/logo_piaget.png',
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                    ),
                    const SizedBox(width: 15), // Espaçamento entre as imagens
                    Flexible(
                      child: Image.asset(
                        'assets/images/logo-IMT.png',
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
