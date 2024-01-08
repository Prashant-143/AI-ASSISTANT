import 'package:ai_assistant/model/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final textc = TextEditingController();

  final list = <Message>[].obs;

  void askQuestion() {
    //USER
    if (textc.text.trim().isNotEmpty) {
      list.add(Message(msg: textc.text, msgType: MessageType.user));
      //AI BOT
      list.add(
          Message(msg: 'I recieved your message', msgType: MessageType.bot));
      textc.text = '';
    }
  }
}
