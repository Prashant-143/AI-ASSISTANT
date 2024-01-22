import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  final textc = TextEditingController();

  Future<void> get askQuestion async {
    if (textc.text.trim().isNotEmpty) {
      textc.text = '';
    }
  }
}
