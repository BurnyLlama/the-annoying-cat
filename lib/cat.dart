import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class Cat {
  // This is a callback function that is run whenever the cat's state changes.
  late Function() _onStatChange;

  // This is needed for the cat to know if it should meow -- how else would it know?
  bool _shouldMeow = false;

  // Create an audio player for use with meows. :3
  final AudioPlayer _player = AudioPlayer();

  // This keeps track of the cat's hunger and maxHunger.
  int _hunger = 1;
  final int maxHunger = 10;

  // This is a list of all possible meow sounds.
  static const _meows = [
    "meow1.mp3",
    "meow2.mp3",
    "meow3.mp3",
    "meow4.mp3",
    "meow5.mp3"
  ];

  // Select a random meow sound from the above list.
  String _selectRandomMeow() {
    int randIndex = Random().nextInt(_meows.length);
    return _meows[randIndex];
  }

  // Play a random meow sound.
  void _meow() {
    if (_shouldMeow) {
      _player.play(AssetSource(_selectRandomMeow()));
    }
  }

  // Increases the cat's hunger by 1.
  void _getHungrier() {
    if (_hunger < maxHunger && Random().nextInt(10) == 7) {
      _hunger += 1;
      _onStatChange();
    }
  }

  // Start a periodic timer that increases hunger.
  void _startHunger() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _getHungrier();

      if (_hunger > 9) {
        startMeow();
      }
    });
  }

  // The cat will start meowing until stopped.
  void startMeow() {
    _shouldMeow = true;
    _meow();
  }

  // This stops the cat from meowing, but it will allow the current meow to finish.
  void stopMeow() {
    _shouldMeow = false;
  }

  // Feed the cat; decreases hunger by 1.
  void feed() {
    if (_hunger > 0) {
      _hunger -= 2;
    }
    stopMeow();
    _onStatChange();
  }

  // Let the outside world see the cat's hunger.
  int getHunger() {
    return _hunger;
  }

  // Initialize the cat.
  Cat({required Function() onStatChange}) {
    // Let the cat meow straight after a previous meow.
    _player.onPlayerComplete.listen((event) {
      _meow();
    });

    // Make sure the cat gets hungrier.
    _startHunger();

    // Make sure to add a callback to be run on a stat change.
    _onStatChange = onStatChange;
  }
}
