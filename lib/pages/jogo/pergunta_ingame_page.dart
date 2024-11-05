import 'package:flutter/material.dart';

class PerguntaIngamePage extends StatelessWidget {
  final String pergunta;
  const PerguntaIngamePage({super.key, required this.pergunta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título e pergunta
            const Text(
              'PERGUNTA:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 120,
              color: const Color.fromARGB(255, 75, 75, 75),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  pergunta,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Alternativas em uma grade 2x2
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  Container(color: Colors.yellow),
                  Container(color: Colors.red),
                  Container(color: Colors.green),
                  Container(color: Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
