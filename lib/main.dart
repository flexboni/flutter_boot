import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int score = 0;
  double height = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  void onTapFloatButton() {
    height += 100;

    if (height >= 300) {
      height = 300;
      ++score;
    }

    setState(() {});

    if (timer == null || !timer!.isActive) {
      timer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
        height -= 50;

        if (height <= 0) {
          height = 0;
          score = 0;
          timer.cancel();
        }

        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          20,
          kToolbarHeight,
          kFloatingActionButtonMargin + 7,
          50 + kFloatingActionButtonMargin,
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Text(
                    'Your score',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$score',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 35,
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 35,
                height: height,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: IconButton.filled(
        onPressed: onTapFloatButton,
        icon: const Icon(Icons.add),
      ),
    );
  }
}
