import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:ai_assistant/controller/image_controller.dart';
import 'package:ai_assistant/widgets/custom_button.dart';
import 'package:ai_assistant/widgets/custom_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

import '../../helper/global.dart';
import '../../helper/my_dialogs.dart';

class ImageFeature extends StatefulWidget {
  const ImageFeature({Key? key}) : super(key: key);

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
  final _c = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Image Creator'),
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: mq.height * 0.02,
              bottom: mq.height * 0.01,
              right: mq.width * 0.04,
              left: mq.width * 0.04,
            ),
            children: [
              TextFormField(
                minLines: 2,
                maxLines: null,
                controller: _c.textc,
                textAlign: TextAlign.center,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  hintText:
                      'Imagine something wonderful & creative\nType here & i will create for you',
                  hintStyle: TextStyle(fontSize: 13.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              Container(
                height: mq.height * 0.5,
                alignment: Alignment.center,
                child: Obx(() => _aiImage()),
              ),
              CustomBtn(
                onTap: () {
                  _c.createAIImage(context);
                },
                text: 'Create',
              ),
            ],
          ),
          // Circular Progress Indicator
          if (_c.isLoading)
            Container(
              color: Colors.black.withOpacity(0.2),
              child: const Center(
                child: CustomLoading(),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadAIImage(context);
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: const Icon(Icons.download),
      ),
    );
  }

  Widget _aiImage() => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: switch (_c.status.value) {
          Status.none =>
            Lottie.asset('assets/lottie/ai_play.json', height: mq.height * .3),
          Status.complete => CachedNetworkImage(
              imageUrl: _c.url,
              placeholder: (context, url) => const CustomLoading(),
              errorWidget: (context, url, error) => const SizedBox(),
            ),
          Status.loading => const CustomLoading()
        },
      );

  //For Downloading AI Generated Image
  Future<void> downloadAIImage(BuildContext context) async {
    try {
      setState(() {
        _c.isLoading = true;
      });

      if (_c.url.isNotEmpty) {
        http.Response response = await http.get(Uri.parse(_c.url));
        Uint8List imageData = response.bodyBytes;

        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/Ai_Image.jpg');

        await tempFile.writeAsBytes(imageData);

        await GallerySaver.saveImage(tempFile.path,
            albumName: 'AI DALL-2 IMAGES');
        log(tempFile.path);
        setState(() {
          _c.isLoading = false;
        });

        MyDialogs.success(msg: "Image saved to gallery");
        log("Image saved to gallery");
      } else {
        setState(() {
          _c.isLoading = false;
        });

        MyDialogs.info(msg: "No image available to save");
      }
    } catch (e) {
      setState(() {
        _c.isLoading = false;
      });

      debugPrint('Error while saving image to gallery: $e');
      MyDialogs.error(msg: "Error while saving image to gallery");
    }
  }
}
