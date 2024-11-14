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
              GestureDetector(
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
                            style: ButtonStyle(
                              overlayColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return const Color.fromARGB(
                                            255, 220, 15, 75)
                                        .withOpacity(0.2); // Efeito hover
                                  }
                                  return null; // Usar o mesmo fundo padrão
                                },
                              ),
                              foregroundColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return const Color.fromRGBO(
                                        255, 215, 90, 1);
                                  }
                                  return const Color.fromARGB(255, 220, 15, 75);
                                },
                              ),
                            ),
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
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "Sobre nós",
                    style: TextStyle(
                      color: Colors.white, // Cor do texto "Sobre nós"
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              // Imagens centralizadas no meio da BottomAppBar
              const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/logo_piaget.png'),
                    height: 700,
                    width: 150,
                  ),
                  SizedBox(width: 15), // Espaçamento entre as imagens
                  Image(
                    image: AssetImage('assets/images/logo-IMT.png'),
                    height: 700,
                    width: 150,
                  ),
                ],
              ),

              // Placeholder para ocupar o espaço no final e equilibrar a centralização
              const SizedBox(width: 50),
            ],
          ),
        ),
      ),
    );
  }
}
