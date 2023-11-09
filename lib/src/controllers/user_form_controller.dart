import 'package:auth_lib/src/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../enums.dart';

class UserFormController extends GetxController {
  final email = "".obs;
  final password = "".obs;
  final error = "".obs;
  final status = UserFormStatus.initial.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repository = Get.find<AuthenticationService>();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }

  void submitForm() async {
    try {
      await repository.logInUser(
          email: emailController.value.text,
          password: passwordController.value.text);
      Get.snackbar(
        "User login",
        "User logged in",
        snackPosition: SnackPosition.BOTTOM,
      );

      // TODO
      // Get.to(() => const StartScreen(), binding: StartBinding());
    } on AuthFailure catch (e) {
      error.value = e.message;
      status.value = UserFormStatus.failure;
    }
  }
}
