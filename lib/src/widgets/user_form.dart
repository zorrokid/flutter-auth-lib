import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_form_controller.dart';
import '../enums.dart';

class UserForm extends GetView<UserFormController> {
  const UserForm({
    super.key,
  });
  Widget _createContentByState(UserFormStatus status, String? error) {
    switch (status) {
      case UserFormStatus.submitting:
        return const Center(child: CircularProgressIndicator());
      case UserFormStatus.success:
        return const Center(child: Text('Success'));
      default:
        return Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              controller: controller.emailController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              controller: controller.passwordController,
            ),
            status == UserFormStatus.failure && error != null
                ? Text(
                    error,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox.shrink(),
          ],
        );
    }
  }

  void _submit(BuildContext context) {
    if (controller.emailController.text.isEmpty ||
        controller.passwordController.text.isEmpty) {
      return;
    }
    controller.submitLogIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: Obx(() => _createContentByState(
          controller.status.value, controller.error.value)),
      floatingActionButton:
          Obx(() => controller.status.value != UserFormStatus.submitting
              ? FloatingActionButton(
                  onPressed: () => _submit(context),
                  child: const Icon(Icons.check),
                )
              : const SizedBox.shrink()),
    );
  }
}
