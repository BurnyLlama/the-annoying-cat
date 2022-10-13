import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class Cat {
  static const _meows = [
    "meow1.mp3",
    "meow2.mp3",
    "meow3.mp3",
    "meow4.mp3",
    "meow5.mp3"
  ];

  bool _shouldMeow = false;

  final AudioPlayer _player = AudioPlayer();

  int _hunger = 0;

  String _selectRandomMeow() {
    int randIndex = Random().nextInt(_meows.length);
    return _meows[randIndex];
  }

  void _meow() {
    if (_shouldMeow) {
      _player.play(AssetSource(_selectRandomMeow()));
    }
  }

  void _getHungrier() {
    if (_hunger < 10 && Random().nextInt(10) == 7) {
      _hunger += 1;
    }
  }

  void _startHunger() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _getHungrier();

      if (_hunger > 9) {
        startMeow();
      }
    });
  }

  void startMeow() {
    _shouldMeow = true;
    _meow();
  }

  void stopMeow() {
    _shouldMeow = false;
  }

  void feed() {
    if (_hunger > 0) {
      _hunger -= 2;
    }
    stopMeow();
  }

  Cat() {
    _player.onPlayerComplete.listen((event) {
      _meow();
    });
    _startHunger();
  }
}
