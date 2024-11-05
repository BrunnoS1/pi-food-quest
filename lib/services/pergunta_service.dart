import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PerguntaService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //funcao para adicionar ou editar pergunta
  Future<void> setPergunta(String documentId, String pergunta, String alt1,
      String alt2, String alt3, String alt4) async {
    DocumentReference docRef = _db.collection('perguntas').doc();

    // cria o documento e adiciona a pergunta
    await docRef.set({
      'pergunta': pergunta,
      'alt1': alt1,
      'alt2': alt2,
      'alt3': alt3,
      'alt4': alt4,
    });
  }

  // Método para buscar uma pergunta aleatória
  Future<Map<String, dynamic>?> getPerguntaAleatoria() async {
    try {
      // Obtém todas as perguntas da coleção
      QuerySnapshot snapshot = await _db.collection('perguntas').get();

      // Verifica se a coleção não está vazia
      if (snapshot.docs.isEmpty) {
        return null; // Retorna null se não houver perguntas
      }

      // Seleciona um índice aleatório
      int randomIndex = Random().nextInt(snapshot.docs.length);

      // Retorna o documento aleatório como um Map
      return snapshot.docs[randomIndex].data() as Map<String, dynamic>;
    } catch (e) {
      print("Erro ao buscar pergunta aleatória: $e");
      return null;
    }
  }

  Stream<List<Map<String, dynamic>>> getListaPerguntas() {
  return _db.collection('perguntas').snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return {
        'documentId': doc.id,
        ...doc.data() as Map<String, dynamic>
      };
    }).toList();
  });
}


  Future<void> removePergunta(String documentId) async {
    try {
      await _db.collection('perguntas').doc(documentId).delete();
      debugPrint('Pergunta removida com sucesso');
    } catch (e) {
      debugPrint('Erro ao remover pergunta: $e');
      throw Exception('Erro ao remover pergunta');
    }
  }

}
