// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:ai_assistant/apis/apis.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:before_after_image_slider_nullsafty/before_after_image_slider_nullsafty.dart';
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

  // final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // late AndroidDeviceInfo androidInfo;

  // Future<Directory> getSaveDirectory() async {
  //   if (Platform.isWindows) {
  //     // Specify the Windows directory
  //     return Directory("C:\\Users\\acer\\Downloads\\AI BG REMOVER");
  //   } else if (Platform.isMacOS) {
  //     // Specify the macOS directory
  //     return Directory("/YourMacOSDirectory");
  //   } else if (Platform.isLinux) {
  //     // Specify the Linux directory
  //     return Directory("/YourLinuxDirectory");
  //   } else {
  //     // For other platforms, you can specify a default directory
  //     return Directory("storage/emulated/0/Download/AI BG REMOVER");
  //   }
  // }

  // downloadImage() async {
  //   if (Platform.isAndroid) {
  //     androidInfo = await deviceInfo.androidInfo;

  //     if (androidInfo.version.sdkInt < 33) {
  //       PermissionStatus status = await Permission.storage.request();

  //       try {
  //         if (status.isGranted) {
  //           // Permission granted, continue with download
  //           try {
  //             log('Android 13 Lower Version Block Is Executed');
  //             var filename = "${DateTime.now().millisecondsSinceEpoch}.png";
  //             final directory = await getSaveDirectory();

  //             if (!await directory.exists()) {
  //               await directory.create(recursive: true);
  //             }

  //             await screenshotController.captureAndSave(
  //               directory.path,
  //               delay: const Duration(milliseconds: 100),
  //               fileName: filename,
  //               pixelRatio: 1.0,
  //             );

  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text("Downloaded to ${directory.path}")),
  //             );
  //           } catch (e) {
  //             log('Error while capturing and saving screenshot: $e');
  //           }
  //         } else if (status.isPermanentlyDenied) {
  //           // Open app settings for manual permission granting
  //           openAppSettings();
  //         }
  //       } catch (e) {
  //         log('Error while checking and requesting storage permission: $e');
  //       }
  //     } else {
  //       log('Android 13 or higher Block Is Executed');

  //       try {
  //         var filename = "${DateTime.now().millisecondsSinceEpoch}.png";
  //         final directory = await getSaveDirectory();

  //         if (!await directory.exists()) {
  //           await directory.create(recursive: true);
  //         }

  //         await screenshotController.captureAndSave(
  //           directory.path,
  //           delay: const Duration(milliseconds: 100),
  //           fileName: filename,
  //           pixelRatio: 1.0,
  //         );

  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("Downloaded to ${directory.path}")),
  //         );
  //       } catch (e) {
  //         log('Error while capturing and saving screenshot: $e');
  //       }
  //     }
  //   }
  // }

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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image saved to gallery")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No image available to save")),
        );
      }
    } catch (e) {
      log('Error while saving image to gallery: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error while saving image to gallery")),
      );
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

          // IconButton(
          //     onPressed: () {
          //       reset();
          //     },
          //     icon: const Icon(Icons.home)),
        ],
        leading: IconButton(
            onPressed: () {
              reset();
            },
            icon: const Icon(Icons.home)),
        elevation: 02.0,
        title: const Text("AI BG Remover"),
        scrolledUnderElevation: 5,
        titleTextStyle: const TextStyle(
            fontSize: 16.0, color: Colors.blue, fontWeight: FontWeight.w500),
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
                      setState(() {});
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
                    )),
      ),
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
            // const SizedBox(height: 30),
            const Text(
              'Select Image From...',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    backgroundColor: Colors.redAccent,
                    child: const Icon(Icons.photo_library),
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                      Get.back();
                    },
                    backgroundColor: Colors.redAccent,
                    child: const Icon(Icons.photo_camera),
                  ),
                ],
              ),
            ),
            const Text(
              'Gallary',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
