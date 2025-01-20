import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:myapp/Homepage.dart';
import 'package:myapp/firebase_options.dart';
import 'startingScreen.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

const GEMINI_API_KEY = 'AIzaSyCrzqhFxN24WIoVg_T8gkf9kI6xv2dog1k';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "You");
  ChatUser geminiUser = ChatUser(
      id: "1",
      firstName: "Ally",
      profileImage:
          "https://iili.io/JvcrWib.jpg");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Gemini.init(apiKey: GEMINI_API_KEY);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Ally'),
          ),
          body: buildUI(),
        ),
      ),
    );
  }

  Widget buildUI() {
    return DashChat(
        currentUser: currentUser, onSend: sendMessage, messages: messages);
  }

  void sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = "${chatMessage.text}give the solution to this problem in short steps so that even a child can understand";
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);

          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print("Error with gemini");
    }
  }
}
