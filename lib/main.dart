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

enum UserType { gpt, me }

class Chat {
  const Chat({required this.type, required this.message});

  final UserType type;
  final String message;
}

const basicGPTMessage =
    'Actually, I don\'t have any features, but one day I\'ll grow up and become ChatGPT!';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _textController;
  late ScrollController _scrollController;

  List<Chat> chats = [];

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
    _scrollController = ScrollController();

    chats.add(
      const Chat(type: UserType.gpt, message: 'Hello, how can i help you?'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(text: 'MyCuteGPT', children: [
            TextSpan(
              text: ' 3.5',
              style: TextStyle(color: Colors.grey[600]),
            )
          ]),
        ),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 10),
                itemCount: chats.length,
                itemBuilder: (BuildContext context, int index) {
                  final Chat chat = chats[index];
                  return ListItem(type: chat.type, message: chat.message);
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Message',
                      fillColor: Colors.grey[300],
                      filled: true,
                      suffixIcon: _textController.text.isNotEmpty
                          ? null
                          : const Icon(Icons.voice_chat),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _textController.text.isNotEmpty
                      ? () {
                          setState(() {
                            chats.addAll([
                              Chat(
                                  type: UserType.me,
                                  message: _textController.text),
                              const Chat(
                                type: UserType.gpt,
                                message: basicGPTMessage,
                              ),
                            ]);

                            _textController.text = '';

                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          });
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      _textController.text.isNotEmpty
                          ? Colors.black
                          : Colors.grey[300],
                    ),
                  ),
                  icon: Icon(
                    Icons.arrow_upward_rounded,
                    color: _textController.text.isNotEmpty
                        ? Colors.white
                        : Colors.grey,
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

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.type,
    this.message,
  });

  final UserType type;
  final String? message;

  final double width = 30;

  @override
  Widget build(BuildContext context) {
    final bool isGpt = type == UserType.gpt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: width,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isGpt ? Colors.green : Colors.purple,
                  borderRadius: const BorderRadius.all(Radius.circular(90))),
              child: Text(
                isGpt ? 'G' : 'FC',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isGpt ? 'MyCuteGPT' : 'FlutterBoot'),
                const SizedBox(height: 3),
              ],
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: width + 5),
            Expanded(
              child: Text(
                message ?? basicGPTMessage,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
