import 'dart:math';

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
  int point = 0;

  Future<void> showPointSelectDialog() async {
    final result = await showDialog<int>(
      context: context,
      builder: (_) {
        final int random = Random().nextInt(100);
        int random2;
        do {
          random2 = Random().nextInt(100);
        } while (random == random2);

        int random3;
        do {
          random3 = Random().nextInt(100);
        } while (random == random3 || random2 == random3);

        return AlertDialog(
          title: const Text('Choose your nest point!'),
          content: const Text(
            'Choose one of the points below! If you don\'t make a selection, your current score will be retained.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, random),
              child: Text('$random'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, random2),
              child: Text('$random2'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, random3),
              child: Text('$random3'),
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        point = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your point : $point'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: showPointSelectDialog,
              child: const Text('I want more points!'),
            ),
          ],
        ),
      ),
    );
  }
}
