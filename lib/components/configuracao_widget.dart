import 'package:flutter/material.dart';
import 'package:food_quest/services/audio_manager.dart'; // Importar o gerenciador de áudio

// Função para mostrar o diálogo de configurações
void mostrarDialogoConfiguracoes(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5), // Tornar o fundo opaco
    builder: (BuildContext context) {
      return const ConfiguracoesDialog();
    },
  );
}

// Widget para o diálogo de configurações
class ConfiguracoesDialog extends StatefulWidget {
  const ConfiguracoesDialog({super.key});

  @override
  _ConfiguracoesDialogState createState() => _ConfiguracoesDialogState();
}

class _ConfiguracoesDialogState extends State<ConfiguracoesDialog> {
  double _volume =
      AudioManager.player.volume; // Volume inicial baseado no AudioManager
  int _lastPrintedVolume = -1; // Para evitar imprimir volume repetidamente

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text('Configurações', style: TextStyle(color: Colors.white)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Volume do Jogo', style: TextStyle(color: Colors.white)),
          Slider(
            value: _volume,
            onChanged: (value) {
              setState(() {
                _volume = value;
                int volumeInt = (_volume * 100).round();
                if (volumeInt % 10 == 0 && volumeInt != _lastPrintedVolume) {
                  _lastPrintedVolume = volumeInt;
                  print("Volume do jogo: $volumeInt");
                }
                // Ajustar o volume do player global
                AudioManager.player.setVolume(_volume);
              });
            },
            min: 0.0,
            max: 1.0,
            activeColor: const Color.fromARGB(255, 220, 15, 75),
            inactiveColor: Colors.white70,
          ),
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.hovered)) {
                  return const Color.fromARGB(255, 220, 15, 75)
                      .withOpacity(0.2);
                }
                return null;
              },
            ),
            foregroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.hovered)) {
                  return const Color.fromRGBO(255, 215, 90, 1);
                }
                return const Color.fromARGB(255, 220, 15, 75);
              },
            ),
          ),
          child: const Text('fechar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
