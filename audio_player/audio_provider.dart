import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioProvider extends ChangeNotifier {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration position = Duration.zero;
  bool isInitialized = false;

  Duration? loopDuration;
  bool isLooping = false;
  int loopHours = 0;
  int loopMinutes = 0;
  int loopSeconds = 0;

  AudioProvider() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;

      if (isLooping && loopDuration != null) {
        if (position.inSeconds >= loopDuration!.inSeconds) {
          position = Duration.zero;
          audioPlayer.seek(Duration.zero);
          audioPlayer.resume();
        }
      }

      notifyListeners();
    });
  }

  Future<void> initAndPlay() async {
    if (!isInitialized) {
      try {
        await audioPlayer.setSource(AssetSource('music/rock-music.mp3'));
        isInitialized = true;
      } catch (e) {
        print('Error loading audio: $e');
        return;
      }
    }

    togglePlayPause();
  }

  void togglePlayPause() async {
    if (!isInitialized) {
      await initAndPlay();
      return;
    }

    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.resume();
    }
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void setLoopTime(String hours, String minutes, String seconds) {
    int hrs = int.tryParse(hours) ?? 0;
    int mins = int.tryParse(minutes) ?? 0;
    int secs = int.tryParse(seconds) ?? 0;

    if (hrs == 0 && mins == 0 && secs == 0) {
      stopLoop();
      return;
    }

    loopHours = hrs;
    loopMinutes = mins;
    loopSeconds = secs;

    loopDuration = Duration(hours: hrs, minutes: mins, seconds: secs);
    isLooping = true;
    position = Duration.zero;

    if (isInitialized) {
      audioPlayer.seek(Duration.zero);
      audioPlayer.resume();
      isPlaying = true;
    }

    notifyListeners();
  }

  void stopLoop() {
    isLooping = false;
    loopDuration = null;
    position = Duration.zero;
    audioPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
