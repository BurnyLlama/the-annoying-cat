import 'package:flutter/material.dart';
import 'cat.dart';

String catPic = "assets/el_gatos.jpg";
double hungerBarValue = 0.0;
double happinessBarValue = 0.0;
double waterBarValue = 0.0;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Pad an element
  Widget padElement(
      {required Widget element,
      double vertical = 0.0,
      double horizontal = 0.0}) {
    return Container(
        margin:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: element);
  }

  // Change which cat pic is displayed.
  changeCatPic(String url) {
    setState(() {
      catPic = url;
    });
  }

  // Change the hunger bar.
  updateStatusBars() {
    setState(() {
      hungerBarValue = cat.remainingFoodSupply / cat.maxFoodSupply;
      happinessBarValue = cat.remainingHappiness / cat.maxHappinessLevel;
      waterBarValue = cat.remainingWaterSupply / cat.maxWaterSupply;
    });
  }

  // This is ugly, but some form of initialization is required...
  late Cat cat;

  @override
  void initState() {
    // Actually initialize.
    cat = Cat(onStatChange: updateStatusBars);
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
              Center(
                  child: padElement(
                      element: Image.asset(catPic), horizontal: 50.0)),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                direction: Axis.horizontal,
                children: [
                  padElement(
                      element: ElevatedButton(
                          onPressed: () {
                            changeCatPic("assets/el_gatos2.jpg");
                            cat.startMeow();
                          },
                          child: const Text("Meow! ^>^")),
                      horizontal: 20.0,
                      vertical: 5.0),
                  padElement(
                      element: ElevatedButton(
                          onPressed: () {
                            changeCatPic("assets/el_gatos.jpg");
                            cat.stopMeow();
                          },
                          child: const Text("Quiet down! >.<")),
                      horizontal: 20.0,
                      vertical: 5.0),
                  padElement(
                      element: ElevatedButton(
                          onPressed: () {
                            cat.feed();
                          },
                          child: const Text("Feed! :3")),
                      horizontal: 20.0,
                      vertical: 5.0),
                  padElement(
                      element: ElevatedButton(
                          onPressed: () {
                            cat.water();
                          },
                          child: const Text("Water! :0")),
                      horizontal: 20.0,
                      vertical: 5.0),
                  padElement(
                      element: ElevatedButton(
                          onPressed: () {
                            cat.pet();
                          },
                          child: const Text("Pet! <3")),
                      horizontal: 20.0,
                      vertical: 5.0),
                ],
              ),
              padElement(
                  element: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: const Text("Food supply:"),
                          ),
                          LinearProgressIndicator(
                            minHeight: 10,
                            value: hungerBarValue,
                            backgroundColor: theme.backgroundColor,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: const Text("Water:"),
                          ),
                          LinearProgressIndicator(
                            minHeight: 10,
                            value: waterBarValue,
                            backgroundColor: theme.backgroundColor,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: const Text("Happiness:"),
                          ),
                          LinearProgressIndicator(
                            minHeight: 10,
                            value: happinessBarValue,
                            backgroundColor: theme.backgroundColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  horizontal: 50.0)
            ],
          )),
    );
  }
}
