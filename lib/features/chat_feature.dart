import 'package:ai_assistant/controller/chat_controller.dart';
import 'package:ai_assistant/widgets/message_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/global.dart';

class ChatBotFeature extends StatefulWidget {
  const ChatBotFeature({super.key});

  @override
  State<ChatBotFeature> createState() => _ChatBotFeatureState();
}

class _ChatBotFeatureState extends State<ChatBotFeature> {
  final _c = ChatController();

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
              controller: _c.textc,
              textAlign: TextAlign.center,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                isDense: true,
                hintText: 'Ask me anything you want...',
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
              onPressed: () {
                _c.askQuestion;
              },
              icon: const Icon(
                Icons.rocket_launch_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),

      //Body
      body: Obx(
        () => ListView(
          physics: const BouncingScrollPhysics(),
          controller: _c.scrollC,
          padding:
              EdgeInsets.only(top: mq.height * 0.02, bottom: mq.height * 0.01),
          children: _c.list.map((e) => MessageCard(message: e)).toList(),
        ),
      ),
    );
  }
}
