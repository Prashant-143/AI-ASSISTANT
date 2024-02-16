// ignore_for_file: use_build_context_synchronously

import 'package:ai_assistant/controller/bg_remove_controller.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:ai_assistant/apis/apis.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:before_after_image_slider_nullsafty/before_after_image_slider_nullsafty.dart';
import '../../helper/global.dart';
import '../../widgets/dashed_border.dart';

class BgRemoverFeature extends StatefulWidget {
  const BgRemoverFeature({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BgRemoverFeatureState createState() => _BgRemoverFeatureState();
}

class _BgRemoverFeatureState extends State<BgRemoverFeature> {
  final _c = BgRemoveController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //Icon Button To Show Download Button
          Visibility(
            visible: isVisible,
            child: IconButton(
                onPressed: () {
                  _c.downloadImage(image);
                },
                icon: const Icon(Icons.download)),
          ),
          //Icon Button To Reset Everthing
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isloaded) // Only show the Container if an image is not loaded
            Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05,
                left: MediaQuery.of(context).size.width * 0.05,
                bottom: MediaQuery.of(context).size.width * 0.05,
              ),
              child: const Text(
                'Upload an image\nto remove the background',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          Center(
            child: removedbg
                ? BeforeAfter(
                    thumbColor: Colors.cyan,
                    imageCornerRadius: 6,
                    thumbRadius: 2,
                    beforeImage: Image.file(File(imagePath)),
                    afterImage: Image.memory(image!),
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
                    : Container(
                        margin: EdgeInsets.only(
                          right: mq.width * 0.03,
                          left: mq.width * 0.03,
                          bottom: mq.width * 0.03,
                        ),
                        width: 300,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(3, 3),
                                blurRadius: 10,
                                spreadRadius: 0,
                                blurStyle: BlurStyle.normal)
                          ],
                        ),
                        child: DashedBorder(
                          padding: const EdgeInsets.all(25),
                          color: Colors.cyan,
                          gap: 3,
                          strokeWidth: 2,
                          radius: 5,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Bounce(
                                  duration: const Duration(milliseconds: 120),
                                  onPressed: () {
                                    bottomsheet();
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(
                                          8), // Rounded corners
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue
                                              .withOpacity(0.5), // Shadow color
                                          spreadRadius: 2, // Spread radius
                                          blurRadius: 4, // Blur radius
                                          offset: const Offset(
                                              0, 2), // Shadow offset
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "UPLOAD IMAGE",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: mq.height * 0.02),
                                const Text(
                                  'No Images? Try one of these:👇',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      EdgeInsets.only(bottom: mq.height * .03),
                                  physics: const BouncingScrollPhysics(),
                                  child: Wrap(
                                    spacing: 10,
                                    children: sampleImagesList
                                        .map(
                                          (e) => InkWell(
                                            onTap: () {
                                              imagePath = e;
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                              child: SizedBox(
                                                height: 100,
                                                child: Image.asset(e),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
          )
        ],
      ),

      //Floating Action Button For Downloading Image
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          onPressed: () {
            _c.downloadImage(image);
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
            const SizedBox(
              width: 80,
              child: Divider(
                thickness: 4,
                color: Colors.grey,
              ),
            ),
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
                    log('Image picked from galary');
                  }, Icons.photo_library, 'Galary'),

                  // SizedBox for some space
                  const SizedBox(width: 16),

                  // Second Button
                  customButton(() {
                    pickImage(ImageSource.camera);
                    Get.back();
                    log('Image picked from camera');
                  }, Icons.camera_alt, 'Camera'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final sampleImagesList = <String>[
    'assets/images/sample_image_1.jpg',
    'assets/images/sample_image_2.jpg',
    'assets/images/sample_image_3.jpg',
    'assets/images/sample_image_4.jpg',
  ].obs;
}
