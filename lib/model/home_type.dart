import 'package:flutter/material.dart';

enum HomeType { aiChatBot, aiImage, aiTranslator, aiBgRemover }

extension MyHomeType on HomeType {
  //title
  String get title => switch (this) {
        HomeType.aiChatBot => 'AI ChatBot',
        HomeType.aiImage => ' AI Image Creator',
        HomeType.aiTranslator => 'Lang Translator',
        HomeType.aiBgRemover => 'AI BG Remover',
      };

  //lottie
  String get lottie => switch (this) {
        HomeType.aiChatBot => 'ai_hand_waving.json',
        HomeType.aiImage => 'ai_play.json',
        HomeType.aiTranslator => 'ai_ask_me.json',
        HomeType.aiBgRemover => 'Bgremover.json',
      };

  //for alignment
  bool get leftAlign => switch (this) {
        HomeType.aiChatBot => true,
        HomeType.aiImage => false,
        HomeType.aiTranslator => true,
        HomeType.aiBgRemover => false,
      };

  //for padding
  EdgeInsets get padding => switch (this) {
        HomeType.aiChatBot => EdgeInsets.zero,
        HomeType.aiImage => const EdgeInsets.all(18),
        HomeType.aiTranslator => EdgeInsets.zero,
        HomeType.aiBgRemover => EdgeInsets.zero,
      };
}
