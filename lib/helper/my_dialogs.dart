import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_loading.dart';

class MyDialogs {
  static success({required String msg}) {
    Get.snackbar('Success', msg,
        colorText: Colors.greenAccent,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal);
  }

  static error({required String msg}) {
    Get.snackbar('Error', msg,
        colorText: Colors.redAccent,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal);
  }

  static info({required String msg}) {
    Get.snackbar('Info', msg,
        colorText: Colors.blue,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal);
  }

  //loading dialog
  static void showLoadingDialog() {
    Get.dialog(const Center(child: CustomLoading()));
  }
}
