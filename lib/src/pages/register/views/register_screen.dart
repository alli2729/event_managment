import '../controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Form(
          key: controller.registerFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _names(),
                  const SizedBox(height: 16),
                  _username(),
                  const SizedBox(height: 16),
                  _password(),
                  const SizedBox(height: 16),
                  _repeatPassword(),
                  const SizedBox(height: 16),
                  _genders(),
                  const SizedBox(height: 16),
                  _registerButton(),
                  const SizedBox(height: 36),
                  _login(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _login() {
    return Row(
      children: [
        const Text('already have an account? ', style: TextStyle(fontSize: 14)),
        Obx(
          () => GestureDetector(
            onTap: (controller.isLoading.value) ? null : controller.onLogin,
            child: const Text(
              'Login now',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF2B4D3E),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _registerButton() {
    return Obx(
      () => GestureDetector(
        onTap: (controller.isLoading.value) ? null : controller.onRegister,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: (controller.isLoading.value)
                ? const Color(0xFF5C6D66)
                : const Color(0xFF2B4D3E),
          ),
          child: const Text(
            'Register',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _genders() {
    return Obx(
      () => Row(
        children: [
          const Text("Male"),
          Radio<String>(
            activeColor: const Color(0xFF2B4D3E),
            value: 'male',
            groupValue: controller.selectedGender.value,
            onChanged: controller.selectGender,
          ),
          const Text("Female"),
          Radio<String>(
            activeColor: const Color(0xFF2B4D3E),
            value: 'female',
            groupValue: controller.selectedGender.value,
            onChanged: controller.selectGender,
          ),
        ],
      ),
    );
  }

  Widget _names() {
    return Row(
      children: [
        Flexible(child: _firstName()),
        const SizedBox(width: 16),
        Flexible(child: _lastName()),
      ],
    );
  }

  Widget _repeatPassword() {
    return Obx(
      () => TextFormField(
        validator: controller.validate,
        controller: controller.repeatPasswordController,
        obscureText: controller.isVisible.value,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: controller.isVisible.toggle,
            icon: (controller.isVisible.value)
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          ),
          prefixIcon: const Icon(Icons.key_outlined),
          hintText: 'repeat Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _password() {
    return Obx(
      () => TextFormField(
        validator: controller.validate,
        controller: controller.passwordController,
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

  Widget _username() {
    return TextFormField(
      validator: controller.validate,
      controller: controller.usernameController,
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

  Widget _lastName() {
    return TextFormField(
      validator: controller.validate,
      controller: controller.lastNameController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_4_outlined),
        labelText: 'Lastname',
        hintText: 'Lastname',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _firstName() {
    return TextFormField(
      validator: controller.validate,
      controller: controller.firstNameController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_4_outlined),
        labelText: 'Firstname',
        hintText: 'Firstname',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Register'),
      leading: IconButton(
        onPressed: (controller.isLoading.value) ? null : controller.onLogin,
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
