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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  Color backColor = Colors.white;
  int score = 0;
  final double iconSize = 50;

  final GlobalKey _buttonKey = GlobalKey();

  Offset? buttonOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final RenderBox? renderBox =
          _buttonKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) {
        return;
      }

      setState(() {
        final Offset offset = renderBox.localToGlobal(Offset.zero);
        buttonOffset = Offset(
          offset.dx + (renderBox.size.width / 2) - iconSize / 2,
          offset.dy + (renderBox.size.height / 2) - iconSize / 2,
        );
      });
    });
  }

  void onTapShoot() {
    _controller.forward();

    // Future.delayed(const Duration(milliseconds: 300), () {
    //   setState(() {
    //     backColor = Colors.blue.shade100;
    //     ++score;
    //   });
    // });

    // Future.delayed(const Duration(milliseconds: 400), () {
    //   setState(() {
    //     backColor = Colors.white;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backColor,
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                  Rect.fromLTWH(
                    (buttonOffset?.dx ?? size.width),
                    (buttonOffset?.dy ?? size.height),
                    0,
                    0,
                  ),
                  constraints.biggest,
                ),
                end: RelativeRect.fromSize(
                  Rect.fromLTWH(
                    0,
                    0,
                    iconSize,
                    iconSize,
                  ),
                  constraints.biggest,
                ),
              ).animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
              ),
              child: const FlutterLogo(),
            ),
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(90),
              ),
              child: Text(
                '$score',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                key: _buttonKey,
                onPressed: onTapShoot,
                child: const Text('Shoot start!'),
              ),
            )
          ],
        );
      }),
    );
  }
}
