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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: isClicked
              ? BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 30,
                      color: Colors.red,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  gradient: SweepGradient(
                    colors: const [Colors.white, Colors.red, Colors.white],
                    transform: GradientRotation(_controller.value * 6),
                  ),
                )
              : null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black,
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  isClicked = true;
                });
              },
              child: Text(
                'Flutter Boot\nClick me 😎',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  shadows: isClicked
                      ? [
                          const Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 20.0,
                            color: Colors.red,
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
