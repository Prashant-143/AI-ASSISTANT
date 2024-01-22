import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        colorText: Colors.orange,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal);
  }
}
