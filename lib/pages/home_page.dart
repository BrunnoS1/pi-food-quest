import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/components/appbar_widget.dart';
import 'package:food_quest/components/bottom_appbar_widget.dart';
import 'package:food_quest/components/configuracao_widget.dart';
import 'package:food_quest/services/usuario_service.dart';

class HomePage extends StatefulWidget {
  final professor;
  const HomePage({super.key, this.professor});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UsuarioService usuarioService = UsuarioService();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      appBar: const AppBarWidget(
        titulo: "",
        logout: true,
        rota: "",
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo na parte de cima da tela
              const Image(
                image: AssetImage('assets/images/logo-FoodQuest.png'),
                height: 100, // Ajuste o tamanho como necessário
              ),

              const SizedBox(height: 200),

              //Texto bem vindo com nome do usuario
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StreamBuilder<String?>(
                      stream: usuarioService.getNome(user.email!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                              color: Color.fromARGB(0, 123, 167, 150));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          String displayName = snapshot.data ?? user.email!;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                const Text(
                                  key: Key("boasvindas"),
                                  "Bem vindo, ",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                                Text(
                                  displayName,
                                  key: const Key("boasvindasNome"),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 220, 15, 75),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 50),

                    //column com os botoes
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            //botao jogar
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: WidgetStateProperty.all(
                                      const Size.fromWidth(150)),
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.pressed)) {
                                        return const Color.fromARGB(
                                            255,
                                            220,
                                            15,
                                            75); // Cor de fundo quando pressionado
                                      }
                                      return const Color.fromRGBO(255, 215, 90,
                                          1); // Cor de fundo padrão
                                    },
                                  ),
                                  foregroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.pressed)) {
                                        return const Color.fromRGBO(
                                            255,
                                            215,
                                            90,
                                            1); // Cor do texto quando pressionado
                                      }
                                      return const Color.fromARGB(255, 220, 15,
                                          75); // Cor do texto padrão
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context,
                                      '/jogo_pergunta'); // colocar nome da página certa
                                },
                                child: const Text(
                                  'Jogar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            //botao configuracoes
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: WidgetStateProperty.all(
                                      const Size.fromWidth(150)),
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.pressed)) {
                                        return const Color.fromARGB(
                                            255, 220, 15, 75);
                                      }
                                      return const Color.fromRGBO(
                                          255, 215, 90, 1);
                                    },
                                  ),
                                  foregroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.pressed)) {
                                        return const Color.fromRGBO(
                                            255,
                                            215,
                                            90,
                                            1); // Cor do texto quando pressionado
                                      }
                                      return const Color.fromARGB(255, 220, 15,
                                          75); // Cor do texto padrão
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  mostrarDialogoConfiguracoes(context);
                                },
                                child: const Text(
                                  'Configurações',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            //botao ranking
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: WidgetStateProperty.all(
                                      const Size.fromWidth(150)),
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.pressed)) {
                                        return const Color.fromARGB(
                                            255, 220, 15, 75);
                                      }
                                      return const Color.fromRGBO(
                                          255, 215, 90, 1);
                                    },
                                  ),
                                  foregroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.pressed)) {
                                        return const Color.fromRGBO(
                                            255,
                                            215,
                                            90,
                                            1); // Cor do texto quando pressionado
                                      }
                                      return const Color.fromARGB(255, 220, 15,
                                          75); // Cor do texto padrão
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/ranking');
                                },
                                child: const Text(
                                  'Ranking',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            //botao perguntas (so aparece se for login de professor)
                            widget.professor
                                ? Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        fixedSize: WidgetStateProperty.all(
                                            const Size.fromWidth(150)),
                                        backgroundColor: WidgetStateProperty
                                            .resolveWith<Color>(
                                          (Set<WidgetState> states) {
                                            if (states.contains(
                                                WidgetState.pressed)) {
                                              return const Color.fromARGB(
                                                  255,
                                                  220,
                                                  15,
                                                  75); // Cor de fundo quando pressionado
                                            }
                                            return const Color.fromRGBO(
                                                255,
                                                215,
                                                90,
                                                1); // Cor de fundo padrão
                                          },
                                        ),
                                        foregroundColor: WidgetStateProperty
                                            .resolveWith<Color>(
                                          (Set<WidgetState> states) {
                                            if (states.contains(
                                                WidgetState.pressed)) {
                                              return const Color.fromRGBO(
                                                  255,
                                                  215,
                                                  90,
                                                  1); // Cor do texto quando pressionado
                                            }
                                            return const Color.fromARGB(
                                                255,
                                                220,
                                                15,
                                                75); // Cor do texto padrão
                                          },
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/perguntas_page');
                                      },
                                      child: const Text(
                                        'Perguntas',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ],
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
