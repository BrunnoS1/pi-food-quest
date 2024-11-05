// import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/components/appbar_widget.dart';
import 'package:food_quest/components/snackbar_widget.dart';
import 'package:food_quest/services/pergunta_service.dart';

class PerguntasPage extends StatefulWidget {
  const PerguntasPage({super.key});

  @override
  State<PerguntasPage> createState() => _PerguntasPageState();
}

class _PerguntasPageState extends State<PerguntasPage> {
  final PerguntaService perguntaService = PerguntaService();
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> _addPergunta() async {
    TextEditingController controllerP = TextEditingController();
    TextEditingController controllerA1 = TextEditingController();
    TextEditingController controllerA2 = TextEditingController();
    TextEditingController controllerA3 = TextEditingController();
    TextEditingController controllerA4 = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar pergunta'),
          content: Column(
            children: [
              TextField(
                key: const Key("addPerguntaField"),
                controller: controllerP,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: "Pergunta"),
              ),
              TextField(
                key: const Key("addA1Field"),
                controller: controllerA1,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: "Alternativa 1"),
              ),
              TextField(
                key: const Key("addA2Field"),
                controller: controllerA2,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: "Alternativa 2"),
              ),
              TextField(
                key: const Key("addA3Field"),
                controller: controllerA3,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: "Alternativa 3"),
              ),
              TextField(
                key: const Key("addA4Field"),
                controller: controllerA4,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: "Alternativa 4"),
              ),
            ],
          ),
          actions: [
            TextButton(
              key: const Key("salvarButton"),
              onPressed: () async {
                String pergunta = controllerP.text;
                String alt1 = controllerA1.text;
                String alt2 = controllerA2.text;
                String alt3 = controllerA3.text;
                String alt4 = controllerA4.text;
                try {
                  await perguntaService.addPergunta(
                      pergunta, alt1, alt2, alt3, alt4);
                  SnackbarUtil.showSnackbar(
                      context, 'Pergunta salva com sucesso!');
                  Navigator.of(context).pop();
                } catch (e) {
                  // debugPrint('Erro ao adicionar pergunta: $e');
                  SnackbarUtil.showSnackbar(
                      context, 'Erro ao salvar a pergunta',
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
                  decoration: const InputDecoration(hintText: "Pergunta"),
                ),
                TextField(
                  key: const Key("editA1Field"),
                  controller: controllerA1,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: "Alternativa 1"),
                ),
                TextField(
                  key: const Key("editA2Field"),
                  controller: controllerA2,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: "Alternativa 2"),
                ),
                TextField(
                  key: const Key("editA3Field"),
                  controller: controllerA3,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: "Alternativa 3"),
                ),
                TextField(
                  key: const Key("editA4Field"),
                  controller: controllerA4,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: "Alternativa 4"),
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
                try {
                  // Atualiza a pergunta no Firestore com o documentId
                  await perguntaService.editPergunta(perguntaData['documentId'],
                      pergunta, alt1, alt2, alt3, alt4);
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

  Future<void> _removePergunta(BuildContext context, String documentId) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Apagar pergunta'),
          content: const Text('Deseja excluir essa pergunta?'),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  debugPrint('Removendo pergunta com ID: $documentId');
                  await perguntaService.removePergunta(documentId);
                  Navigator.of(context).pop();
                  SnackbarUtil.showSnackbar(
                      context, 'Pergunta removida com sucesso');
                } catch (e) {
                  debugPrint('Erro ao remover pergunta: $e');
                  SnackbarUtil.showSnackbar(context, 'Erro ao remover pergunta',
                      isError: true);
                }
              },
              child: const Text(
                'Remover',
                key: Key("removerPopup"),
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
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
      appBar: const AppBarWidget(titulo: 'Perguntas', rota: '/home_prof'),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: perguntaService.getListaPerguntas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 220, 15, 75)));
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Sem dados'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma pergunta encontrada'));
          }

          List<Map<String, dynamic>> perguntaList = snapshot.data!;

          return ListView.builder(
            itemCount: perguntaList.length,
            itemBuilder: (context, index) {
              var perguntaData = perguntaList[index];
              return Card(
                color: const Color.fromRGBO(255, 215, 90, 1),
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    key: Key("perguntaListText_$index"),
                    '${perguntaData['pergunta']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    await _editPergunta(context, perguntaData);
                  },
                  onLongPress: () async {
                    try {
                      await _removePergunta(
                          context, perguntaData['documentId']);
                    } catch (e) {
                      // Handle error
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      // Botão para criar nova info de pergunta
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
              _addPergunta();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
