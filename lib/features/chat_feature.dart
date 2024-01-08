import 'package:ai_assistant/controller/chat_controller.dart';
import 'package:flutter/material.dart';

class ChatBotFeature extends StatefulWidget {
  const ChatBotFeature({super.key});

  @override
  State<ChatBotFeature> createState() => _ChatBotFeatureState();
}

class _ChatBotFeatureState extends State<ChatBotFeature> {
  ChatController _c = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        title: const Text('Chat with AI Assitant'),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
          //Text Input Feild
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.center,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Ask me anyhting you want...',
                hintStyle: TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          ),
          //For adding some space
          const SizedBox(width: 8),

          //Send button
          CircleAvatar(
            radius: 24,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.rocket_launch,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),

      //Body
      body: ListView(
        children: _c.list.map((e) => Text(e.msg)).toList(),
      ),
    );
  }
}
