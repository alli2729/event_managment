import '../../../../generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _loginText(),
                  const SizedBox(height: 48),
                  _username(),
                  const SizedBox(height: 16),
                  _password(),
                  const SizedBox(height: 16),
                  _rememberMe(),
                  const SizedBox(height: 16),
                  _loginButton(),
                  const SizedBox(height: 24),
                  _register()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginText() {
    return Text(
      LocaleKeys.event_managment_app_login_page_login.tr,
      style: const TextStyle(fontSize: 48),
    );
  }

  Widget _register() {
    return Row(
      children: [
        Text(
          LocaleKeys.event_managment_app_login_page_dont_have_account.tr,
          style: const TextStyle(fontSize: 14),
        ),
        Obx(
          () => GestureDetector(
            onTap: (controller.isLoading.value) ? null : controller.onRegister,
            child: Text(
              LocaleKeys.event_managment_app_login_page_register_now.tr,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF2B4D3E),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginButton() {
    return GestureDetector(
      onTap: (controller.isLoading.value) ? null : controller.onLogin,
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: (controller.isLoading.value)
                ? const Color(0xFF5C6D66)
                : const Color(0xFF2B4D3E),
          ),
          child: Text(
            LocaleKeys.event_managment_app_login_page_login.tr,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _rememberMe() {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            activeColor: const Color(0xFF2B4D3E),
            value: controller.isRemember.value,
            onChanged: controller.rememberToggle,
          ),
        ),
        Text(
          LocaleKeys.event_managment_app_login_page_remember_me.tr,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _username() {
    return TextFormField(
      controller: controller.userController,
      validator: controller.validate,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        labelText: LocaleKeys.event_managment_app_login_page_username.tr,
        hintText: LocaleKeys.event_managment_app_login_page_username.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _password() {
    return Obx(
      () => TextFormField(
        controller: controller.passController,
        validator: controller.validate,
        obscureText: controller.isVisible.value,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: controller.isVisible.toggle,
            icon: (controller.isVisible.value)
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          ),
          prefixIcon: const Icon(Icons.key_outlined),
          labelText: LocaleKeys.event_managment_app_login_page_password.tr,
          hintText: LocaleKeys.event_managment_app_login_page_password.tr,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
