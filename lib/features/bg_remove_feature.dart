// ignore_for_file: use_build_context_synchronously

import 'package:ai_assistant/helper/my_dialogs.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:ai_assistant/apis/apis.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:before_after_image_slider_nullsafty/before_after_image_slider_nullsafty.dart';
import '../helper/global.dart';
import '../widgets/dashed_border.dart';

class BgRemoverFeature extends StatefulWidget {
  const BgRemoverFeature({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BgRemoverFeatureState createState() => _BgRemoverFeatureState();
}

class _BgRemoverFeatureState extends State<BgRemoverFeature> {
  var isloaded = false;
  var removedbg = false;
  var isloading = false;
  var isVisible = false;

  Uint8List? image;
  String imagePath = '';

  // Function to reset the state

  void reset() {
    isloaded = false;
    removedbg = false;
    isloading = false;
    isVisible = false;
    image = null;
    imagePath = '';
    setState(() {});
  }

  // Future<void> checkAndRequestPermissions() async {
  //   if (Platform.isAndroid) {
  //     final PermissionStatus storagePermissionStatus =
  //         await Permission.storage.status;
  //     if (storagePermissionStatus.isDenied) {
  //       if (await isAndroidVersionAtLeast(33)) {
  //         // Request specific permissions for Android 13 or higher
  //         await _requestSpecificMediaPermissions();
  //       } else {
  //         // Request general storage permission for Android versions below 13
  //         await _requestStoragePermission();
  //       }
  //     }
  //   }
  // }

  // Future<bool> isAndroidVersionAtLeast(int version) async {
  //   final AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
  //   final int sdkInt = androidInfo.version.sdkInt;
  //   return sdkInt >= version;
  // }

  // Future<void> _requestSpecificMediaPermissions() async {
  //   try {
  //     final Map<Permission, PermissionStatus> permissionStatuses = await [
  //       Permission.mediaLibrary,
  //       Permission.photos,
  //       Permission.videos,
  //       Permission.audio,
  //       Permission.accessMediaLocation,
  //       Permission.accessMediaLocation,
  //       Permission.bluetooth,
  //       Permission.bluetoothConnect,
  //       Permission.bluetoothScan,
  //       Permission.camera,
  //       Permission.contacts,
  //     ].request();
  //     // Handle permission statuses if needed
  //   } catch (e) {
  //     // Handle permission request error
  //     print('Error requesting specific media permissions: $e');
  //   }
  // }

  // Future<void> _requestStoragePermission() async {
  //   try {
  //     final PermissionStatus status = await Permission.storage.request();
  //     if (status.isDenied) {
  //       // Handle if permission is denied for storage
  //       final bool isPermanentlyDenied =
  //           await Permission.storage.isPermanentlyDenied;
  //       if (isPermanentlyDenied) {
  //         // Open app settings if permission is permanently denied
  //         await openAppSettings();
  //       }
  //     }
  //   } catch (e) {
  //     // Handle permission request error
  //     log('Error requesting storage permission: $e');
  //   }
  // }

  ScreenshotController screenshotController = ScreenshotController();
  // APIs api = APIs(); // Instance of the Api class

  void pickImage(ImageSource source) async {
    final img =
        await ImagePicker().pickImage(source: source, imageQuality: 100);

    if (img != null) {
      imagePath = img.path;
      isloaded = true;
      setState(() {});
    } else {}
  }

  Future<void> downloadImage() async {
    try {
      if (image != null) {
        // Create a temporary file to save the image

        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/Ai_bg_remover.png');

        // Write the image data to the temporary file
        await tempFile.writeAsBytes(image!);

        // Save the temporary file to the gallery
        await GallerySaver.saveImage(tempFile.path, albumName: 'AI BG REMOVER');

        MyDialogs.success(msg: "Image saved to gallery");
      } else {
        MyDialogs.info(msg: "No image available to save");
      }
    } catch (e) {
      log('Error while saving image to gallery: $e');

      MyDialogs.error(msg: "Error while saving image to gallery");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: isVisible,
            child: IconButton(
                onPressed: () {
                  downloadImage();
                },
                icon: const Icon(Icons.download)),
          ),
          // IconButton(
          //     onPressed: () {
          //       pickImage(ImageSource.camera);
          //       setState(() {});
          //     },
          //     icon: const Icon(Icons.camera_alt)),

          IconButton(
              onPressed: () {
                reset();
              },
              icon: const Icon(Icons.home)),
        ],
        elevation: 02.0,
        title: const Text("AI BG Remover"),
        scrolledUnderElevation: 5,
        titleTextStyle: const TextStyle(
            fontSize: 18.0, color: Colors.blue, fontWeight: FontWeight.w500),
      ),
      body: Center(
        child: removedbg
            ? BeforeAfter(
                thumbColor: Colors.cyan,
                imageCornerRadius: 6,
                thumbRadius: 2,
                beforeImage: Image.file(File(imagePath)),
                afterImage: Screenshot(
                  controller: screenshotController,
                  child: Image.memory(image!),
                ),
              )
            : isloaded
                ? GestureDetector(
                    onTap: () {
                      bottomsheet();
                      // checkAndRequestPermissions();
                      // setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: DashedBorder(
                        radius: 3,
                        strokeWidth: 2,
                        padding: const EdgeInsets.all(5),
                        color: Colors.cyan,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          child: Image.file(
                            File(imagePath),
                          ),
                        ),
                      ),
                    ),
                  )
                : DashedBorder(
                    padding: const EdgeInsets.all(40),
                    color: Colors.cyan,
                    gap: 3,
                    strokeWidth: 2,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          bottomsheet();
                        },
                        child: const Text("CHOOSE IMAGE"),
                      ),
                    ),
                  ),
      ),

      //Floating Action Button For Downloading Image

      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          onPressed: () {
            downloadImage();
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: const Icon(Icons.download),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: isloaded && !removedbg
                ? () async {
                    setState(() {
                      isloading = true;
                    });

                    image = await APIs.removeBG(imagePath);

                    if (image != null) {
                      removedbg = true;
                      isVisible = true;
                      isloading = false;
                      setState(() {});
                    }
                  }
                : null,
            child: isloading
                ? const CircularProgressIndicator(
                    color: Color.fromARGB(255, 255, 255, 255),
                  )
                : const Text("Remove Background"),
          ),
        ),
      ),
    );
  }

  Future<dynamic> bottomsheet() {
    return Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: 250,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Select Image From...',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // First Button
                  customButton(() {
                    pickImage(ImageSource.gallery);
                    Get.back();
                  }, Icons.photo_album_outlined, 'Galary'),

                  // SizedBox for some space
                  const SizedBox(width: 16),

                  // Second Button
                  customButton(() {
                    pickImage(ImageSource.camera);
                    Get.back();
                  }, Icons.camera_alt, 'Camera'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
