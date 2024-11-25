import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';

class UsuarioService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  //funçõs para nome
  Future<void> setNome(String nome) async {
    //define o campo de nome e o campo de acertos com 0
    final user = FirebaseAuth.instance.currentUser!;
    await _db
        .collection('Usuarios')
        .doc(user.email)
        .set({'nome': nome, 'pontos': 0}, SetOptions(merge: true));
  }

  Stream<String?> getNome(String documentId) {
    //retorna o campo nome do usuario
    return _db
        .collection('Usuarios')
        .doc(documentId)
        .snapshots()
        .map((snapshot) {
      return snapshot.data()?['nome'] as String?;
    });
  }

  Future<void> sendVerificationEmail() async {
    //envia email de verificaçao (firebase)
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> incrementaAcerto(String email, String alternativa) async {
    try {
      // Pegar o doc por email (id)
      DocumentReference docRef = _db.collection('Usuarios').doc(email);

      // Transacao para incrementar os pontos ou criar o doc/campo se nao existir
      await _db.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);

        if (snapshot.exists) {
          // Se o documento existir incrementar pontos
          transaction.update(docRef, {
            'pontos': FieldValue.increment(1),
          });
        } else {
          // Criar o documento se nao existir
          transaction.set(docRef, {
            'pontos': 1, // Criar com 1 ponto
          });
        }
      });

      debugPrint("Pontos incrementados para o usuário: $email");
    } catch (e) {
      debugPrint("Erro ao atualizar contagem de acertos: $e");
    }
  }

  Stream<List<Map<String, dynamic>>> getRankingUsers() {
    return _db
        .collection('Usuarios')
        .orderBy('pontos', descending: true) // Ordenar pelos pontos desc
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {
              'documentId': doc.id, // = email
              'pontos': doc['pontos'],
            }).toList());
  }
}
