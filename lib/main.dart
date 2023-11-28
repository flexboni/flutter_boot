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

const double STAR_SIZE = 48;

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double yOffset = STAR_SIZE;
  double xOffset = STAR_SIZE;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Timer.periodic(
      const Duration(milliseconds: 5),
      (timer) {
        xOffset += 5;
        if (xOffset > MediaQuery.of(context).size.width * 2) {
          xOffset = STAR_SIZE;
          yOffset += STAR_SIZE;
        }

        if (yOffset + STAR_SIZE > MediaQuery.of(context).size.height * 2) {
          xOffset = STAR_SIZE;
          yOffset = STAR_SIZE;
        }

        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (_, constraint) {
              return Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.topLeft,
                color: Colors.black,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      width: xOffset,
                      height: yOffset,
                      duration: const Duration(microseconds: 5),
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (_, child) {
                          return Transform.rotate(
                            angle: _controller.value * 2 * pi,
                            child: child,
                          );
                        },
                        child: const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: STAR_SIZE,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
