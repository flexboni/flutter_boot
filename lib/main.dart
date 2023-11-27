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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Text(
                  'FlutterBoot Plus',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Child(
                  icon: Icons.check,
                  title: 'Premium features',
                  content:
                      'Plus subscribers have access to FlutterBoot+ and out latest beta features.',
                ),
                SizedBox(height: 20),
                Child(
                  icon: Icons.fireplace_rounded,
                  title: 'Priority access',
                  content:
                      'You\'ll be able to use FlutterBoot+ even when demand is heigh',
                ),
                SizedBox(height: 20),
                Child(
                  icon: Icons.speed_rounded,
                  title: 'Ultra-fast',
                  content:
                      'Enjoy even faster response speeds when using FlutterBoot',
                ),
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Restore subscription',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Auto-renews for \$25/month until canceled'),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: const Text(
                      'Subscribe',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Child extends StatelessWidget {
  const Child({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 30),
        const SizedBox(width: 10),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(content),
            ],
          ),
        ),
      ],
    );
  }
}
