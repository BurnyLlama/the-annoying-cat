import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

AudioPlayer player = AudioPlayer();
String catPic = "assets/el_gatos.jpg";

void main() => runApp(const MyApp());

String selectRandomMeow() {
  List<String> meows = [
    "meow1.mp3",
    "meow2.mp3",
    "meow3.mp3",
    "meow4.mp3",
    "meow5.mp3"
  ];

  int randIndex = Random().nextInt(meows.length);

  return meows[randIndex];
}

bool shouldPlayMeow = true;
void playMeow() {
  if (shouldPlayMeow) {
    player.play(AssetSource(selectRandomMeow()));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  changeCatPic(String url) {
    setState(() {
      catPic = url;
    });
  }

  @override
  void initState() {
    player.onPlayerComplete.listen((event) {
      playMeow();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Little Meow Meow',
      theme: ThemeData.from(
          useMaterial3: false,
          textTheme: const TextTheme(button: TextStyle(fontFamily: "Rubik")),
          colorScheme: const ColorScheme.dark(
              background: Color.fromARGB(255, 22, 64, 4),
              primary: Color.fromARGB(255, 19, 214, 6),
              surface: Color.fromARGB(255, 22, 128, 4))),
      home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Ɛ> My Annoying Kittens <3')),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("My Garden with my Annoying Kittens! <3"),
              Center(child: Image.asset(catPic)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        shouldPlayMeow = true;
                        changeCatPic("assets/el_gatos2.jpg");
                        playMeow();
                      },
                      child: const Text("Meow! ^>^")),
                  ElevatedButton(
                      onPressed: () {
                        shouldPlayMeow = false;
                        changeCatPic("assets/el_gatos.jpg");
                        player.stop();
                      },
                      child: const Text("SHUT UP! >.<"))
                ],
              )
            ],
          )),
    );
  }
}
