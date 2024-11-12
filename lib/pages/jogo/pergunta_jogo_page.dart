import 'dart:math';
import 'package:flutter/material.dart';
import 'package:food_quest/services/pergunta_service.dart';

class PerguntaJogoPage extends StatefulWidget {
  final int initialQuestionIndex;

  const PerguntaJogoPage({super.key, required this.initialQuestionIndex});

  @override
  State<PerguntaJogoPage> createState() => _PerguntaJogoPageState();
}

class _PerguntaJogoPageState extends State<PerguntaJogoPage> {
  PerguntaService perguntaService = PerguntaService();
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
    setState(() {}); // Reconstruir depois de definir o tamanho da lista de perguntas
  }

  bool verificaResposta(String resposta, String alternativa) {
    if (alternativa == resposta) {
      debugPrint('acertou');
      return true;
    }
    debugPrint('errou');
    return false;
  }

  void computaResposta(String resposta, String alternativa) {
    final acertou = verificaResposta(resposta, alternativa);
    perguntaService.contAcertoErro(acertou, currentQuestionIndex, alternativa);

    // Mostrar popup de resposta correta/errada
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(acertou ? "Acertou!" : "Errou!"),
          content: Text(
              acertou ? "Você acertou a resposta!" : "Resposta incorreta."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o popup
                setState(() {
                  // Incrementa indice da pergunta atual e acertos local depois de fechar
                  currentQuestionIndex++;
                  if (acertou) acertos++;
                  if (currentQuestionIndex >= totalPerguntas || currentQuestionIndex >= 10) {
                    currentQuestionIndex = 0;
                    Navigator.pushNamed(context, '/posjogo_page', arguments: (acertos, min(totalPerguntas,10)));
                  }
                });
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: FutureBuilder<Map<String, dynamic>?>(
        future: PerguntaService().getPerguntaIndex(currentQuestionIndex),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Erro ao carregar pergunta"));
          }

          //Dados da snapshot
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
                Text(
                  questionText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
                                  print("Yellow box tapped");
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
                                  print("Red box tapped");
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
                                  print("Green box tapped");
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
                                  print("Blue box tapped");
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

