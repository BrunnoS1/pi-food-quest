import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/services/pergunta_service.dart';
import 'package:food_quest/services/usuario_service.dart';

class PerguntaJogoPage extends StatefulWidget {
  final int initialQuestionIndex;

  const PerguntaJogoPage({super.key, required this.initialQuestionIndex});

  @override
  State<PerguntaJogoPage> createState() => _PerguntaJogoPageState();
}

class _PerguntaJogoPageState extends State<PerguntaJogoPage> {
  PerguntaService perguntaService = PerguntaService();
  UsuarioService usuarioService = UsuarioService();
  late int currentQuestionIndex;
  late int totalPerguntas;
  int acertos = 0;


  @override
  void initState() {
    super.initState();
    currentQuestionIndex = widget.initialQuestionIndex;
    initializeTotalPerguntas();
  }

  Future<void> initializeTotalPerguntas() async {
    totalPerguntas = await perguntaService.getTotalPerguntas();
    setState(() {}); // Rebuild depois de pegar as perguntas
  }

  void computaResposta(String resposta, String alternativa) {
    final acertou = alternativa == resposta;
    perguntaService.contAcertoErro(acertou, currentQuestionIndex, alternativa);
    if (acertou) {
      final user = FirebaseAuth.instance.currentUser!;
      usuarioService.incrementaAcerto(user.email!, alternativa);
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 75, 75, 75),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Bordas arredondadas
          ),
          title: Row(
            children: [
              Icon(
                acertou ? Icons.emoji_events : Icons.close,
                color: acertou ? Colors.green[700] : Colors.red[700],
                size: 30,
              ),
              const SizedBox(width: 10),
              Text(
                acertou ? "Parabéns!" : "Que pena!",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: Text(
            acertou
                ? "Você acertou a resposta! Continue assim."
                : "Você errou. Não desista, a próxima você acerta!",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: acertou ? Colors.green : Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex++;
                  if (acertou) acertos++;
                  if (currentQuestionIndex >= totalPerguntas ||
                      currentQuestionIndex >= 10) {
                    Navigator.pushNamed(
                      context,
                      '/posjogo_page',
                      arguments: (acertos, min(totalPerguntas, 10)),
                    );
                  }
                });
              },
              child: const Text(
                "Continuar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void timeout() {
    // Função para trocar de pergunta após o tempo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 75, 75, 75),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.timer_off,
                color: Color.fromARGB(255, 220, 15, 75),
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Acabou o tempo!",
                style: TextStyle(
                  color: Color.fromARGB(255, 220, 15, 75),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            "Tempo esgotado! Prepare-se para a próxima pergunta.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 220, 15, 75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex++;
                  if (currentQuestionIndex >= totalPerguntas ||
                      currentQuestionIndex >= 10) {
                    currentQuestionIndex = 0;
                    Navigator.pushNamed(
                      context,
                      '/posjogo_page',
                      arguments: (acertos, min(totalPerguntas, 10)),
                    );
                  }
                });
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      body: FutureBuilder<Map<String, dynamic>?>( // Carregando as perguntas
        future: PerguntaService().getPerguntaIndex(currentQuestionIndex),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Erro ao carregar pergunta"));
          }

          final data = snapshot.data!;
          final questionText = data['pergunta'] ?? '';
          final yellowText = data['alt1'] ?? '';
          final redText = data['alt2'] ?? '';
          final greenText = data['alt3'] ?? '';
          final blueText = data['alt4'] ?? '';
          final resposta = data['resposta'] ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CountdownTimer(
                  key: ValueKey(currentQuestionIndex),
                  duration: 60,
                  onTimeout: timeout,
                ),
                const SizedBox(height: 16),
                Text(
                  questionText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  computaResposta(resposta, '1');
                                },
                                child: Container(
                                  color: Colors.yellow,
                                  child: Center(
                                    child: Text(
                                      yellowText,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  computaResposta(resposta, '2');
                                },
                                child: Container(
                                  color: Colors.red,
                                  child: Center(
                                    child: Text(
                                      redText,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  computaResposta(resposta, '3');
                                },
                                child: Container(
                                  color: Colors.green,
                                  child: Center(
                                    child: Text(
                                      greenText,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  computaResposta(resposta, '4');
                                },
                                child: Container(
                                  color: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      blueText,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


class CountdownTimer extends StatefulWidget {
  //classe para criar o timer, só é usada dentro dessa pagina
  final int duration;
  final VoidCallback onTimeout;

  const CountdownTimer(
      {super.key, required this.duration, required this.onTimeout});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late int _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        widget.onTimeout();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Tempo restante: $_remainingTime",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }
}