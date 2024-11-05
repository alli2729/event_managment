import '../../../../generated/locales.g.dart';
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
                  _image(context),
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

  Widget _image(BuildContext context) {
    return Image.asset(
      'assets/images/register.png',
      package: 'event_managment',
      width: pageWidth(context) / 1.5,
    );
  }

  Widget _login() {
    return Row(
      children: [
        Text(
          LocaleKeys.event_managment_app_register_page_already_have_acc.tr,
          style: const TextStyle(fontSize: 14),
        ),
        Obx(
          () => GestureDetector(
            onTap: (controller.isLoading.value) ? null : controller.onLogin,
            child: Text(
              LocaleKeys.event_managment_app_register_page_login_now.tr,
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
          child: Text(
            LocaleKeys.event_managment_app_register_page_register.tr,
            style: const TextStyle(
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
          Text(LocaleKeys.event_managment_app_register_page_male.tr),
          Radio<String>(
            activeColor: const Color(0xFF2B4D3E),
            value: 'male',
            groupValue: controller.selectedGender.value,
            onChanged: controller.selectGender,
          ),
          Text(LocaleKeys.event_managment_app_register_page_female.tr),
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
          hintText:
              LocaleKeys.event_managment_app_register_page_repeat_password.tr,
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
        validator: controller.passValidate,
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
          labelText: LocaleKeys.event_managment_app_register_page_password.tr,
          hintText: LocaleKeys.event_managment_app_register_page_password.tr,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _username() {
    return TextFormField(
      validator: controller.userValidate,
      controller: controller.usernameController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        labelText: LocaleKeys.event_managment_app_register_page_username.tr,
        hintText: LocaleKeys.event_managment_app_register_page_username.tr,
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
        labelText: LocaleKeys.event_managment_app_register_page_lastname.tr,
        hintText: LocaleKeys.event_managment_app_register_page_lastname.tr,
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
        labelText: LocaleKeys.event_managment_app_register_page_firstname.tr,
        hintText: LocaleKeys.event_managment_app_register_page_firstname.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(LocaleKeys.event_managment_app_register_page_register.tr),
      leading: IconButton(
        onPressed: (controller.isLoading.value) ? null : controller.onLogin,
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  double pageWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
}
