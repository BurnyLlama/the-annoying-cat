import 'package:flutter/material.dart';
import 'cat.dart';

String catPic = "assets/el_gatos.jpg";
double hungerBarValue = 0.0;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Change which cat pic is displayed.
  changeCatPic(String url) {
    setState(() {
      catPic = url;
    });
  }

  // Change the hunger bar.
  hungerBar() {
    setState(() {
      hungerBarValue = cat.getHunger() / cat.maxHunger;
    });
  }

  // This is ugly, but some form of initialization is required...
  Cat cat = Cat(onStatChange: () {});

  @override
  void initState() {
    // Actually initialize.
    cat = Cat(onStatChange: () {
      hungerBar();
    });
    super.initState();
  }

  ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: "Manrope",
    // colorScheme: const ColorScheme.dark(
    //   background: Color.fromARGB(255, 22, 64, 4),
    //   primary: Color.fromARGB(255, 19, 234, 6),
    //   surface: Color.fromARGB(255, 22, 128, 4),
    //   onSurface: Color.fromARGB(255, 165, 234, 172),
    //   onBackground: Color.fromARGB(255, 165, 234, 172),
    //   onPrimary: Color.fromARGB(255, 165, 234, 172),
    //   onSurfaceVariant: Color.fromARGB(255, 165, 234, 172),
    // ),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 36, 107, 5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Little Meow Meow',
      theme: theme,
      home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text(' <3 My Annoying Kittens <3 ')),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("My Garden with my Annoying Kittens! <3 "),
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
              ),
              Column(
                children: [
                  const Text("Hunger:"),
                  LinearProgressIndicator(
                    minHeight: 10,
                    value: hungerBarValue,
                    backgroundColor: theme.backgroundColor,
                  ),
                ],
              ),
              Column(
                children: [
                  const Text("Happiness:"),
                  LinearProgressIndicator(
                    minHeight: 10,
                    value: 0.5,
                    backgroundColor: theme.backgroundColor,
                  ),
                ],
              )
            ],
          )),
    );
  }
}
