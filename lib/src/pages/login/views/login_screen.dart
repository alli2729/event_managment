import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.userController,
              validator: controller.validate,
            ),
            TextFormField(
              controller: controller.passController,
              validator: controller.validate,
            ),
            Obx(
              () => Checkbox(
                value: controller.isRemember.value,
                onChanged: controller.rememberToggle,
              ),
            ),
            ElevatedButton(
              onPressed: controller.onLogin,
              child: const Text('LOGIN'),
            ),
            ElevatedButton(
              onPressed: controller.onRegister,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
