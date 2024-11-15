// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_quest/components/appbar_widget.dart';
import 'package:food_quest/components/snackbar_widget.dart';
import 'package:food_quest/services/pergunta_service.dart';

class VisualizaPerguntaPage extends StatefulWidget {
  const VisualizaPerguntaPage({super.key});

  @override
  State<VisualizaPerguntaPage> createState() => _VisualizaPerguntaPageState();
}

class _VisualizaPerguntaPageState extends State<VisualizaPerguntaPage> {
  final PerguntaService perguntaService = PerguntaService();
  Map<String, dynamic>? perguntaData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the initial pergunta data from arguments
    perguntaData ??= ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  }

  Future<void> _editPergunta(
      BuildContext context, Map<String, dynamic> perguntaData) async {
    TextEditingController controllerP =
        TextEditingController(text: perguntaData['pergunta']);
    TextEditingController controllerA1 =
        TextEditingController(text: perguntaData['alt1']);
    TextEditingController controllerA2 =
        TextEditingController(text: perguntaData['alt2']);
    TextEditingController controllerA3 =
        TextEditingController(text: perguntaData['alt3']);
    TextEditingController controllerA4 =
        TextEditingController(text: perguntaData['alt4']);
    TextEditingController controllerResposta =
        TextEditingController(text: perguntaData['resposta']);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar pergunta'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  key: const Key("editPerguntaField"),
                  controller: controllerP,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Pergunta"),
                ),
                TextField(
                  key: const Key("editA1Field"),
                  controller: controllerA1,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Alternativa 1"),
                ),
                TextField(
                  key: const Key("editA2Field"),
                  controller: controllerA2,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Alternativa 2"),
                ),
                TextField(
                  key: const Key("editA3Field"),
                  controller: controllerA3,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Alternativa 3"),
                ),
                TextField(
                  key: const Key("editA4Field"),
                  controller: controllerA4,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Alternativa 4"),
                ),
                TextField(
                  key: const Key("editRespostaField"),
                  controller: controllerResposta,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: "Alternativa correta (1, 2, 3, 4)"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              key: const Key("salvarEdicaoButton"),
              onPressed: () async {
                String pergunta = controllerP.text;
                String alt1 = controllerA1.text;
                String alt2 = controllerA2.text;
                String alt3 = controllerA3.text;
                String alt4 = controllerA4.text;
                String resposta = controllerResposta.text;

                try {
                  // Update the question in Firestore
                  await perguntaService.editPergunta(perguntaData['documentId'],
                      pergunta, alt1, alt2, alt3, alt4, resposta);

                  // Update local perguntaData and refresh the view
                  setState(() {
                    this.perguntaData = {
                      ...perguntaData,
                      'pergunta': pergunta,
                      'alt1': alt1,
                      'alt2': alt2,
                      'alt3': alt3,
                      'alt4': alt4,
                      'resposta': resposta,

                    };
                  });

                  SnackbarUtil.showSnackbar(
                      context, 'Pergunta editada com sucesso!');
                  Navigator.of(context).pop();
                } catch (e) {
                  SnackbarUtil.showSnackbar(
                      context, 'Erro ao editar a pergunta',
                      isError: true);
                }
              },
              child:
                  const Text('Salvar', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (perguntaData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      appBar: const AppBarWidget(
          titulo: 'Detalhes da pergunta', rota: '/perguntas_page'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Pergunta:',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 215, 90),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(perguntaData!['pergunta'] ?? 'N/A',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              'Alternativas:',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 215, 90),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text('1. ${perguntaData!['alt1'] ?? '0'}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            Text('2. ${perguntaData!['alt2'] ?? '0'}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            Text('3. ${perguntaData!['alt3'] ?? '0'}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            Text('4. ${perguntaData!['alt4'] ?? '0'}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              'Resposta Correta:',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 215, 90),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(perguntaData!['resposta'] ?? 'N/A',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              'Estatísticas:',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 215, 90),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text('Acertos: ${perguntaData!['acertos'] ?? '0'}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            Text('Erros: ${perguntaData!['erros'] ?? '0'}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              'Respostas Selecionadas:',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 215, 90),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text('1: ${perguntaData!['respondeu1'] ?? '0'}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            Text('2: ${perguntaData!['respondeu2'] ?? '0'}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            Text('3: ${perguntaData!['respondeu3'] ?? '0'}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            Text('4: ${perguntaData!['respondeu4'] ?? '0'}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 220, 15, 75),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            key: const Key("botaoAddpergunta"),
            onPressed: () {
              _editPergunta(context, perguntaData!);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
