import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/components/appbar_widget.dart';
import 'package:food_quest/components/bottom_appbar_widget.dart';
import 'package:food_quest/services/usuario_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UsuarioService usuarioService = UsuarioService();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        titulo: "Food Quest",
        logout: true,
        rota: "",
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),

              //Texto bem vindo com nome do usuario
              StreamBuilder<String?>(
                stream: usuarioService.getNome(user.email!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                        color: Color.fromARGB(0, 123, 167, 150));
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    String displayName = snapshot.data ?? user.email!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            key: Key("boasvindas"),
                            "Bem vindo ",
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            displayName,
                            key: const Key("boasvindasNome"),
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
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

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: WidgetStateProperty.all(
                                  const Size.fromWidth(120)),
                              backgroundColor:
                                  WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return const Color.fromARGB(0, 123, 167, 150);
                                }
                                return const Color.fromRGBO(255, 215, 90, 1)!;
                              }),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/'); //colocar nome da pagina
                            },
                            child: const Text(
                              'Jogar',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: WidgetStateProperty.all(
                                  const Size.fromWidth(120)),
                              backgroundColor:
                                  WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return const Color.fromARGB(0, 123, 167, 150);
                                }
                                return const Color.fromRGBO(255, 215, 90, 1)!;
                              }),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/'); //colocar nome da página
                            },
                            child: const Text(
                              'Configurações',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}

