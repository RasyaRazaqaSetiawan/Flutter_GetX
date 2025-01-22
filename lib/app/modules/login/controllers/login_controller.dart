import 'package:belajarmobile/app/modules/dashboard/views/dashboard_view.dart';
import 'package:belajarmobile/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final _getConnect = GetConnect();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();

  final loginFormKey = GlobalKey<FormState>();

  void loginNow() async {
    if (!loginFormKey.currentState!.validate()) {
      Get.snackbar(
        'Error',
        'Periksa kembali input Anda',
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final response = await _getConnect.post(BaseUrl.login,
        {'email': emailController.text, 'password': passwordController.text});

    if (response.statusCode == 200) {
      authToken.write('token', response.body['token']);
      Get.offAll(() => const DashboardView());
    } else {
      Get.snackbar(
        'Error',
        response.body['error'].toString(),
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        forwardAnimationCurve: Curves.bounceIn,
        margin: const EdgeInsets.only(
          top: 10,
          left: 5,
          right: 5,
        ),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
