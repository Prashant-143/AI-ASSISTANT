import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:ai_assistant/helper/my_dialogs.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class BgRemoveController extends GetxController {
  Future<void> downloadImage(Uint8List? image) async {
    try {
      if (image != null) //
      {
        MyDialogs.showLoadingDialog();
        // Create a temporary file to save the image
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/Ai_bg_remover.png');

        // Write the image data to the temporary file
        await tempFile.writeAsBytes(image);

        // Save the temporary file to the gallery
        await GallerySaver.saveImage(tempFile.path, albumName: 'AI BG REMOVER')
            .then((success) {
          //hide loading
          Get.back();

          MyDialogs.success(msg: 'Image Downloaded to Gallery!');
        });
      } else {
        Get.back();
        MyDialogs.info(msg: "No image available to save");
      }
    } catch (e) {
      Get.back();
      MyDialogs.error(msg: 'Something Went Wrong (Try again in sometime)!');
      log('downloadImageBGRemover: $e');
    }
  }
}
