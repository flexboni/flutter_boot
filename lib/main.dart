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
  late TextEditingController _firstController;
  late TextEditingController _secondController;
  late FocusNode _firstNode;
  late FocusNode _secondNode;
  bool isEmpty = false;

  @override
  void initState() {
    super.initState();

    _firstController = TextEditingController(text: 'Hello');
    _secondController = TextEditingController(text: 'FlutterBoot!');
    _firstNode = FocusNode();
    _secondNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello TextField!'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: _firstNode,
                controller: _firstController,
                onSubmitted: (_) {
                  _secondNode.requestFocus();
                },
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: KeyboardListener(
                focusNode: FocusNode(),
                onKeyEvent: (event) {
                  if (isEmpty &&
                      _secondController.text.isEmpty &&
                      event.logicalKey.keyLabel == 'Backspace') {
                    _firstNode.requestFocus();
                  } else if (!isEmpty &&
                      _secondController.text.isEmpty &&
                      event.logicalKey.keyLabel == 'Backspace') {
                    isEmpty = true;
                  }
                },
                child: TextField(
                  focusNode: _secondNode,
                  controller: _secondController,
                  onChanged: (_) {
                    isEmpty = false;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
