import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

AudioPlayer player = AudioPlayer();

void main() => runApp(const MyApp());

bool shouldPlayMeow = true;
void playMeow() {
  if (shouldPlayMeow) {
    player.play(AssetSource("meow.mp3")).whenComplete(playMeow);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      theme: ThemeData.from(
          useMaterial3: false,
          textTheme: const TextTheme(button: TextStyle(fontFamily: "Rubik")),
          colorScheme: ColorScheme.fromSeed(
              background: const Color.fromARGB(255, 22, 64, 4),
              seedColor: const Color.fromARGB(255, 19, 214, 68))),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('My annoying kittens'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(child: Image.asset("assets/el_gatos.jpg")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        shouldPlayMeow = true;
                        playMeow();
                      },
                      child: const Text("Meow!")),
                  ElevatedButton(
                      onPressed: () {
                        shouldPlayMeow = false;
                        player.stop();
                      },
                      child: const Text("SHUT UP!"))
                ],
              )
            ],
          )),
    );
  }
}
