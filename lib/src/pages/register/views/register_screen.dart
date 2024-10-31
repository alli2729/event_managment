import '../controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.registerFormKey,
        child: Column(
          children: [
            TextFormField(
              validator: controller.validate,
              controller: controller.firstNameController,
            ),
            TextFormField(
              validator: controller.validate,
              controller: controller.lastNameController,
            ),
            TextFormField(
              validator: controller.validate,
              controller: controller.usernameController,
            ),
            TextFormField(
              validator: controller.validate,
              controller: controller.passwordController,
            ),
            TextFormField(
              validator: controller.validate,
              controller: controller.repeatPasswordController,
            ),
            Obx(
              () => Row(
                children: [
                  const Text("Male"),
                  Radio<String>(
                    value: 'male',
                    groupValue: controller.selectedGender.value,
                    onChanged: controller.selectGender,
                  ),
                  const Text("Female"),
                  Radio<String>(
                    value: 'female',
                    groupValue: controller.selectedGender.value,
                    onChanged: controller.selectGender,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: controller.onRegister,
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: controller.onLogin,
              child: const Text('back to login'),
            ),
          ],
        ),
      ),
    );
  }
}
