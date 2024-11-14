// import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_quest/components/appbar_widget.dart';
import 'package:food_quest/services/usuario_service.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

String _getUserEmail(String email) {
  // retorna o que tiver antes do @ ou o email inteiro se nao der match
  final RegExp regex = RegExp(r'^[^@]+');
  final match = regex.firstMatch(email);
  return match != null
      ? match.group(0)!
      : email; 
}

class _RankingPageState extends State<RankingPage> {
  final UsuarioService usuarioService = UsuarioService();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      appBar: const AppBarWidget(
        titulo: 'Ranking de Jogadores',
        rota: '/auth_page',
      ),
      body: Column(
        children: [
          // Header row with "Jogador" and "Pontos"
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jogador',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Pontos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Expanded ListView to show the ranking list
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: usuarioService.getRankingUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 220, 15, 75),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Sem dados'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum usuario encontrado'));
                }

                List<Map<String, dynamic>> userList = snapshot.data!;

                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    var userData = userList[index];
                    return Card(
                      color: const Color.fromRGBO(255, 215, 90, 1),
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          key: Key("rankingText_$index"),
                          '${_getUserEmail(userData['documentId'])}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          '${userData['pontos']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 220, 15, 75),
                            fontSize: 24,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
