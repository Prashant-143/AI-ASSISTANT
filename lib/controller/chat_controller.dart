import 'package:ai_assistant/apis/apis.dart';
import 'package:ai_assistant/helper/my_dialogs.dart';
import 'package:ai_assistant/model/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final textc = TextEditingController();

  final scrollC = ScrollController();

  final list = <Message>[
    Message(
        msg:
            'Hello,\nI am an AI Bot developed by Prashant Verma.\nHow can i assist you?',
        msgType: MessageType.bot)
  ].obs;

  Future<void> get askQuestion async {
    //USER
    if (textc.text.trim().isNotEmpty) {
      list.add(Message(msg: textc.text, msgType: MessageType.user));
      list.add(Message(msg: '', msgType: MessageType.bot));
      _scrollDown();

      final apiRes = await APIs.getAnswer(textc.text);

      //AI BOT
      list.removeLast();
      list.add(Message(msg: apiRes, msgType: MessageType.bot));
      _scrollDown();

      textc.text = '';
    } else {
      MyDialogs.info(msg: 'Ask Something!');
    }
  }

  //For moving to end message
  void _scrollDown() {
    scrollC.animateTo(scrollC.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
