import 'package:ai_assistant/screens/features/chat_feature.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/features/bg_remove_feature.dart';
import '../screens/features/image_feature.dart';
import '../screens/features/translator_feature.dart';

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

  // For onTap
  VoidCallback get onTap => switch (this) {
        HomeType.aiChatBot => () => Get.to(() => const ChatBotFeature()),
        HomeType.aiImage => () => Get.to(() => const ImageFeature()),
        HomeType.aiTranslator => () => Get.to(() => const TransaltorFeature()),
        HomeType.aiBgRemover => () => Get.to(() => const BgRemoverFeature()),
      };
}
