import 'package:ai_assistant/controller/image_controller.dart';
import 'package:ai_assistant/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../helper/global.dart';

class ImageFeature extends StatefulWidget {
  const ImageFeature({super.key});

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
  final _c = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        title: const Text('AI Image Creator'),
      ),

      //Body

      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            top: mq.height * 0.02,
            bottom: mq.height * 0.01,
            right: mq.width * 0.04,
            left: mq.width * 0.04),
        children: [
          TextFormField(
            minLines: 2,
            maxLines: null,
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

          //AI Image Lottie

          Container(
            height: mq.height * 0.5,
            alignment: Alignment.center,
            child: Lottie.asset('assets/lottie/ai_play.json',
                height: mq.height * 0.3),
          ),
          CustomBtn(onTap: () {}, text: 'Create')
        ],
      ),
    );
  }
}
