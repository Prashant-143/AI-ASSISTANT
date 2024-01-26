import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/model/messages.dart';

import '../helper/global.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({super.key, required this.message});
  static const r = Radius.circular(15);

  @override
  Widget build(BuildContext context) {
    return message.msgType == MessageType.bot

        //FOR BOT MSG
        ? Row(
            children: [
              const SizedBox(width: 6),
              //
              CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Image.asset(appLogo, width: 24)),
              //
              Container(
                constraints: BoxConstraints(maxWidth: mq.width * 0.6),
                margin: EdgeInsets.only(
                    bottom: mq.height * 0.02, left: mq.width * 0.02),
                padding: EdgeInsets.symmetric(
                    vertical: mq.height * 0.02, horizontal: mq.width * 0.02),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: const BorderRadius.only(
                      topLeft: r, topRight: r, bottomLeft: r),
                ),
                child: Text(message.msg),
              ),
            ],
          )
        :
        //FOR USER MSG
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: mq.width * 0.6),
                margin: EdgeInsets.only(
                    bottom: mq.height * 0.02, right: mq.width * 0.02),
                padding: EdgeInsets.symmetric(
                    vertical: mq.height * 0.02, horizontal: mq.width * 0.02),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: const BorderRadius.only(
                      topLeft: r, topRight: r, bottomRight: r),
                ),
                child: message.msg.isEmpty
                    ? AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('Please Wait... ',
                              speed: const Duration(milliseconds: 100))
                        ],
                        repeatForever: true,
                      )
                    : Text(
                        message.msg,
                        textAlign: TextAlign.center,
                      ),
              ),
              //
              const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person)),
              const SizedBox(width: 6),
            ],
          );
  }
}
