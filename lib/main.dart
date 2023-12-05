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

const HELLO = 'Hello!';
const PRESS = 'Press';
const ANY = 'any!';
const BUTTON = 'button!';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _helloKey = GlobalKey();
  final GlobalKey _pressKey = GlobalKey();
  final GlobalKey _anyKey = GlobalKey();
  final GlobalKey _buttonKey = GlobalKey();

  OverlayEntry? overlayEntry;

  @override
  void dispose() {
    removeOverlay();

    super.dispose();
  }

  void removeOverlay() {
    if (overlayEntry == null) {
      return;
    }

    overlayEntry!.remove();
    overlayEntry!.dispose();
    overlayEntry = null;
  }

  Offset getPosition(RenderBox box) {
    final Size size = box.size;
    final Offset offset = box.localToGlobal(Offset.zero);

    return Offset(
        (offset.dx + size.width) / 2, (offset.dy - size.height / 3 * 2));
  }

  void createOverlay(Offset offset) {
    removeOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy,
          child: FittedBox(
            fit: BoxFit.none,
            child: IgnorePointer(
              ignoring: true,
              child: Material(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black.withOpacity(0.4),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_downward),
                      Text(' You clicked this 😎'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello Overlay'), centerTitle: true),
      body: Stack(
        children: [
          ModalBarrier(onDismiss: removeOverlay),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                MyButton(
                  key: _helloKey,
                  onPressed: () {
                    Offset offset = getPosition(
                      _helloKey.currentContext?.findRenderObject() as RenderBox,
                    );
                    createOverlay(offset);
                  },
                  title: 'Hello!',
                ),
                const SizedBox(height: 10),
                MyButton(
                  key: _pressKey,
                  onPressed: () {
                    Offset offset = getPosition(
                      _pressKey.currentContext?.findRenderObject() as RenderBox,
                    );
                    createOverlay(offset);
                  },
                  title: 'Press',
                ),
                const SizedBox(height: 10),
                MyButton(
                  key: _anyKey,
                  onPressed: () {
                    Offset offset = getPosition(
                      _anyKey.currentContext?.findRenderObject() as RenderBox,
                    );
                    createOverlay(offset);
                  },
                  title: 'any',
                ),
                const SizedBox(height: 10),
                MyButton(
                  key: _buttonKey,
                  onPressed: () {
                    Offset offset = getPosition(
                      _buttonKey.currentContext?.findRenderObject()
                          as RenderBox,
                    );
                    createOverlay(offset);
                  },
                  title: 'button!',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.title, this.onPressed});

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
      child: Text(title),
    );
  }
}
