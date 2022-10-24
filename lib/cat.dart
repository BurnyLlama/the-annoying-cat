import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class Cat {
  // This is a callback function that is run whenever the cat's state changes.
  late Function() _onStatChange;

  // START: Meow
  // This is needed for the cat to know if it should meow -- how else would it know?
  bool _shouldMeow = false;

  // Create an audio player for use with meows. :3
  final AudioPlayer _player = AudioPlayer();

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

  // The cat will start meowing until stopped.
  void startMeow() {
    _shouldMeow = true;
    // Only start meowing if not already meowing.
    if (_player.state != PlayerState.playing) {
      _meow();
    }
  }

  // This stops the cat from meowing, but it will allow the current meow to finish.
  void stopMeow() {
    _shouldMeow = false;
  }
  // END: Meow

  // START: Food
  // This keeps track of the cat's hunger and maxHunger.
  int _foodSupply = 5;
  final int maxFoodSupply = 10;

  // Increases the cat's hunger by 1.
  void _decreaseFoodSupply() {
    if (_foodSupply > 0) {
      _foodSupply -= 1;
      _onStatChange();
    }
  }

  // Start a periodic timer that increases hunger.
  void _startFoodConsumption() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (Random().nextInt(10) == 7) {
        _decreaseFoodSupply();
      }

      if (_foodSupply == 0) {
        startMeow();
      }
    });
  }

  // Feed the cat; increases food supply by 1.
  void feed() {
    if (_foodSupply < maxFoodSupply) {
      _foodSupply += 1;
      _onStatChange();
    }
  }

  // Let the outside world see the cat's hunger.
  int get remainingFoodSupply {
    return _foodSupply;
  }
  // END: Food

  // START: Water
  // Keep track of the water supply.
  int _waterSupply = 5;
  final int maxWaterSupply = 10;

  // Decrease the water supply by 1.
  void _decreaseWaterSupply() {
    if (_waterSupply > 0) {
      _waterSupply -= 1;
      _onStatChange();
    }
  }

  // Start a periodic timer that makes sure that the cat gets thirsty.
  void _startThirst() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (Random().nextInt(10) == 7) {
        _decreaseWaterSupply();
      }

      if (_waterSupply == 0) {
        startMeow();
      }
    });
  }

  // Give the cat some water; increases the water supply by 1.
  void water() {
    if (_waterSupply < maxWaterSupply) {
      _waterSupply += 1;
      _onStatChange();
    }
  }

  // Get the remaining amount of water.
  int get remainingWaterSupply {
    return _waterSupply;
  }
  // END: Water

  // START: Happiness
  // Keep track of the cat's happiness levels
  int _happinessLevel = 10;
  final int maxHappinessLevel = 20;

  // Decrease happiness level by 1.
  void _decreaseHappinessLevel() {
    if (_happinessLevel > 0) {
      _happinessLevel -= 1;
      _onStatChange();
    }
  }

  // The cat will periodically lose happiness.
  void _startBoredom() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (Random().nextInt(17) == 7) {
        _decreaseHappinessLevel();
      }

      if (_happinessLevel == 0) {
        startMeow();
      }
    });
  }

  // Increase happiness level by 1.
  void pet() {
    if (_happinessLevel < maxHappinessLevel) {
      _happinessLevel += 1;
      _onStatChange();
    }
  }

  int get remainingHappiness {
    return _happinessLevel;
  }
  // END: Happiness

  // Initialize the cat.
  Cat({required Function() onStatChange}) {
    // Let the cat meow straight after a previous meow.
    _player.onPlayerComplete.listen((event) {
      _meow();
    });

    // Make sure the cat gets hungrier.
    _startFoodConsumption();

    // Make sure the cat becomes bored.
    _startBoredom();

    // Make sure the cat gets thirsty.
    _startThirst();

    // Make sure to add a callback to be run on a stat change.
    _onStatChange = onStatChange;
  }
}
