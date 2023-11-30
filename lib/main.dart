import 'dart:async';
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
  Timer? timer;
  Stopwatch stopwatch = Stopwatch();
  double? widthPosition;
  double? heightPosition;

  final ValueNotifier<int> millisecond = ValueNotifier(0);

  void startTimer() {
    stopwatch.start();

    timer = Timer.periodic(
      const Duration(milliseconds: 16),
      (t) {
        millisecond.value = stopwatch.elapsedMilliseconds;
      },
    );

    setState(() {});

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        widthPosition =
            (MediaQuery.of(context).size.width - 50) * Random().nextDouble();
        heightPosition =
            (MediaQuery.of(context).size.height - 50) * Random().nextDouble();
      });
    });
  }

  void stopTimer() {
    assert(timer != null);

    timer!.cancel();
    stopwatch.stop();
    stopwatch.reset();

    setState(() {
      widthPosition = null;
      heightPosition = null;
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) {
        return "$n";
      }
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String milliseconds =
        (duration.inMilliseconds % 1000).toString().padLeft(3, '0');

    return "$twoDigitMinutes:$twoDigitSeconds.$milliseconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catch green game'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: (timer?.isActive ?? false) ? null : startTimer,
              child: const Text('Start!'),
            ),
            ValueListenableBuilder(
              valueListenable: millisecond,
              builder: (_, value, __) {
                return Text(formatDuration(Duration(milliseconds: value)));
              },
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Stack(
                  children: [
                    if (widthPosition != null && heightPosition != null)
                      Positioned(
                        left: widthPosition,
                        top: heightPosition,
                        child: FittedBox(
                          fit: BoxFit.none,
                          child: InkWell(
                            onTap: stopTimer,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
