import 'dart:developer';
import 'dart:io';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/helper/my_dialogs.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

enum Status { none, loading, complete }

class ImageController extends GetxController {
  var isLoading = false;
  final textc = TextEditingController();

  final status = Status.none.obs;

  String url = '';

  Future<void> createAIImage(BuildContext context) async {
    try {
      log('AI CREATE BUTTON TAPPED');
      OpenAI.apiKey = apiKey;
      log('Text value: ${textc.text.trim()}');

      if (textc.text.trim().isNotEmpty) {
        log('IF BLOCK OF CREATE AI EXECUTED');

        OpenAI.apiKey = apiKey;
        status.value = Status.loading;
        OpenAIImageModel image = await OpenAI.instance.image.create(
          prompt: textc.text,
          n: 1,
          size: OpenAIImageSize.size512,
          responseFormat: OpenAIImageResponseFormat.url,
        );

        url = image.data[0].url.toString();

        textc.text = '';
        status.value = Status.complete;
        log(url);
      } else {
        log('AI CREATE ELSE BLOCK IS EXECUTED');
        MyDialogs.info(msg: 'Provide some beautiful image description.');
      }
    } catch (e, stackTrace) {
      log('Error creating AI image: $e');
      log('Stack Trace: $stackTrace');

      // Handle the error as needed, for example, set status to none
      status.value = Status.none;
    }
  }

  void downloadImage() async {
    try {
      //To show loading
      MyDialogs.showLoadingDialog();

      log('url: $url');

      final bytes = (await get(Uri.parse(url))).bodyBytes;
      final dir = await getTemporaryDirectory();

      final file = await File('${dir.path}/ai_image.png').writeAsBytes(bytes);

      log('filePath: ${file.path}');
      //save image to gallery
      await GallerySaver.saveImage(file.path, albumName: appName)
          .then((success) {
        //hide loading
        Get.back();

        MyDialogs.success(msg: 'Image Downloaded to Gallery!');
      });
    } catch (e) {
      //hide loading
      Get.back();
      MyDialogs.error(msg: 'Something Went Wrong (Try again in sometime)!');
      log('downloadImageE: $e');
    }
  }
}
