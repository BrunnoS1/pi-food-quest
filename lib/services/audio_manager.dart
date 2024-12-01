import 'package:just_audio/just_audio.dart';

class AudioManager {
  static final AudioPlayer _player = AudioPlayer();

  // Initialize the audio player with an asset file
  static Future<void> initialize() async {
    try {
      // Set the audio source to an asset
      await _player.setAsset('assets/sounds/music.mp3');
      _player.setVolume(0.3); // Set the initial volume
      _player.setLoopMode(LoopMode.one);
    } catch (e) {
      print('Error loading audio file: $e');
    }
  }

  // Access the player
  static AudioPlayer get player => _player;

  // Dispose the player to release resources
  static void dispose() {
    _player.dispose();
  }
}
