import 'package:flutter/material.dart';
import 'cat.dart';

String catPic = "assets/el_gatos.jpg";

void main() => runApp(const MyApp());

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

  Cat cat = Cat();

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
                        changeCatPic("assets/el_gatos2.jpg");
                        cat.startMeow();
                      },
                      child: const Text("Meow! ^>^")),
                  ElevatedButton(
                      onPressed: () {
                        changeCatPic("assets/el_gatos.jpg");
                        cat.stopMeow();
                      },
                      child: const Text("SHUT UP! >.<")),
                  ElevatedButton(
                      onPressed: () {
                        cat.feed();
                      },
                      child: const Text("Feed! :3")),
                ],
              )
            ],
          )),
    );
  }
}
