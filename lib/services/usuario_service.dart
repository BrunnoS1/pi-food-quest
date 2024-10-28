import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';

class UsuarioService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  //funçõs para nome

  Future<void> setNome(String nome) async {
    final user = FirebaseAuth.instance.currentUser!;
    await _db
        .collection('Usuarios')
        .doc(user.email)
        .set({'nome': nome}, SetOptions(merge: true));
  }

  Stream<String?> getNome(String documentId) {
    return _db
        .collection('Usuarios')
        .doc(documentId)
        .snapshots()
        .map((snapshot) {
      return snapshot.data()?['nome'] as String?;
    });
  }

  Future<void> sendVerificationEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
