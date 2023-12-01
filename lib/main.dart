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

final Map<String, int> spaceData = {
  'NGC 162': 1862,
  '87 Sylvia': 1866,
  'R 136a1': 1985,
  '28978 Ixion': 2001,
  'NGC 6715': 1778,
  '94400 Hongdaeyong': 2001,
  '6354 Vangelis': 1934,
  'C/2020 F3': 2020,
  'Cartwheel Galaxy': 1941,
  'Sculptor Dwarf Elliptical Galaxy': 1937,
  'Eight-Burst Nebula': 1835,
  'Rhea': 1672,
  'C/1702 H1': 1702,
  'Messier 5': 1702,
  'Messier 50': 1711,
  'Cassiopeia A': 1680,
  'Great Comet of 1680': 1680,
  'Butterfly Cluster': 1654,
  'Triangulum Galaxy': 1654,
  'Comet of 1729': 1729,
  'Omega Nebula': 1745,
  'Eagle Nebula': 1745,
  'Small Sagittarius Star Cloud': 1764,
  'Dumbbell Nebula': 1764,
  '54509 YORP': 2000,
  'Dia': 2000,
  '63145 Choemuseon': 2000,
};

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My First ListView!'),
        centerTitle: true,
      ),
      body: ListView.separated(
        controller: _controller,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        itemCount: spaceData.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, index) {
          final String key = spaceData.keys.toList()[index];
          final int? value = spaceData[key];

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(),
            ),
            child: Row(
              children: [
                const Expanded(child: Center(child: Icon(Icons.rocket))),
                Expanded(flex: 9, child: Text('$key was discovered in $value')),
              ],
            ),
          );
        },
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          _controller.animateTo(
            _controller.position.minScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        icon: const Icon(Icons.arrow_upward_rounded),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => Colors.purple[100],
          ),
        ),
      ),
    );
  }
}
