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
                  const Text('LOGIN', style: TextStyle(fontSize: 48)),
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

  Widget _register() {
    return Row(
      children: [
        const Text('dont have an account? ', style: TextStyle(fontSize: 14)),
        GestureDetector(
          onTap: controller.onRegister,
          child: const Text(
            'Register now',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF2B4D3E),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginButton() {
    return GestureDetector(
      onTap: controller.onLogin,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF2B4D3E),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
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
        const Text('remember me', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _username() {
    return TextFormField(
      controller: controller.userController,
      validator: controller.validate,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        labelText: 'Username',
        hintText: 'Username',
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
          labelText: 'Password',
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
