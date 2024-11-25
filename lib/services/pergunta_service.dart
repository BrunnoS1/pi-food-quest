import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PerguntaService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //funcao para editar pergunta
  Future<void> editPergunta(String documentId, String pergunta, String alt1,
      String alt2, String alt3, String alt4, String resposta) async {
    DocumentReference docRef = _db.collection('perguntas').doc(documentId);

    // cria o documento e adiciona a pergunta
    await docRef.set({
      'pergunta': pergunta,
      'alt1': alt1,
      'alt2': alt2,
      'alt3': alt3,
      'alt4': alt4,
      'resposta': resposta,
    });
  }

  //funcao para adicionar pergunta
  Future<void> addPergunta(String pergunta, String alt1, String alt2,
      String alt3, String alt4, String resposta) async {
    DocumentReference docRef = _db.collection('perguntas').doc();

    // cria o documento e adiciona a pergunta
    // atributos numericos comecam em 0
    await docRef.set({
      'pergunta': pergunta,
      'alt1': alt1,
      'alt2': alt2,
      'alt3': alt3,
      'alt4': alt4,
      'resposta': resposta,
      'acertos': 0,
      'erros': 0,
      'respondeu1': 0,
      'respondeu2': 0,
      'respondeu3': 0,
      'respondeu4': 0,
    });
  }

  Future<void> contAcertoErro(
      bool acertou, int index, String alternativa) async {
        //funcao para incrementar a contagem de acertos/erros da pergunta
    try {
      QuerySnapshot snapshot = await _db.collection('perguntas').get();

      // Retorna o documento
      DocumentReference docRef = snapshot.docs[index].reference;

      if (acertou) {
        // Incrementar acertos e a alternativa respondida
        await docRef.update({
          'acertos': FieldValue.increment(1),
          'respondeu$alternativa': FieldValue.increment(1),
        });
      } else {
        // Incrementar erros e a alternativa respondida
        await docRef.update({
          'erros': FieldValue.increment(1),
          'respondeu$alternativa': FieldValue.increment(1),
        });
      }
    } catch (e) {
      debugPrint("Erro ao atualizar contagem de acertos/erros: $e");
    }
  }

  // Método para buscar uma pergunta pelo indice
  Future<Map<String, dynamic>?> getPerguntaIndex(int index) async {
    try {
      // Obtém todas as perguntas da coleção
      QuerySnapshot snapshot = await _db.collection('perguntas').get();

      // Verifica se a coleção não está vazia
      if (snapshot.docs.isEmpty) {
        return null; // Retorna null se não houver perguntas
      }

      // Retorna o documento aleatório como um Map
      return snapshot.docs[index].data() as Map<String, dynamic>;
    } catch (e) {
      debugPrint("Erro ao buscar pergunta: $e");
      return null;
    }
  }

  Future<int> getTotalPerguntas() async {
    //retorna o tamanho da lista de perguntas
    try {
      QuerySnapshot snapshot = await _db.collection('perguntas').get();
      return snapshot.size;
    } catch (e) {
      debugPrint("Erro ao contar perguntas: $e");
      return 0;
    }
  }

  Stream<List<Map<String, dynamic>>> getListaPerguntas() {
    //retorna uma lista com todas as perguntas
    return _db.collection('perguntas').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return {'documentId': doc.id, ...doc.data() as Map<String, dynamic>};
      }).toList();
    });
  }

  Future<void> removePergunta(String documentId) async {
    //funcao para remover pergunta
    try {
      await _db.collection('perguntas').doc(documentId).delete();
      debugPrint('Pergunta removida com sucesso');
    } catch (e) {
      debugPrint('Erro ao remover pergunta: $e');
      throw Exception('Erro ao remover pergunta');
    }
  }

  Future<String> getTituloPergunta(String documentId) async {
    // Pegar o documento com o id
    DocumentSnapshot snapshot = await _db.collection('perguntas').doc(documentId).get();

    // Checar se doc existe ou nao e retornar so o titulo (a pergunta)
    if (snapshot.exists) {
      return snapshot.get('pergunta').toString();
    } else {
      throw Exception('Document not found');
    }
  }
}
