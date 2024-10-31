import '../../../infrastructure/common/utils.dart';
import '../models/register_user_dto.dart';
import '../repositories/register_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final registerFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final _repository = RegisterRepository();

  RxnString selectedGender = RxnString();

  void selectGender(String? gender) {
    selectedGender.value = gender!;
  }

  //* registration --------------------------------------

  void onRegister() => checkUserExist();

  Future<void> checkUserExist() async {
    if (!isFormValidate()) return;

    final result = await _repository.chekUserExist(
      username: usernameController.text,
    );

    result.fold(
      (exception) {
        Utils.showFailSnackBar(message: exception);
      },
      (notExist) {
        registerByDto();
      },
    );
  }

  Future<void> registerByDto() async {
    final RegisterUserDto dto = RegisterUserDto(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      gender: selectedGender.value!,
      username: usernameController.text,
      password: passwordController.text,
    );

    final result = await _repository.registerByDto(dto: dto);

    result.fold(
      (exception) {
        Utils.showFailSnackBar(message: exception);
      },
      (success) {
        Get.back(result: {
          "username": usernameController.text,
          "password": passwordController.text,
        });
      },
    );
  }

  void onLogin() {
    Get.back();
  }

  //* Validations --------------------------------------------------------

  bool isFormValidate() {
    if (!(registerFormKey.currentState?.validate() ?? false)) return false;

    if (passwordController.text != repeatPasswordController.text) {
      Utils.showFailSnackBar(message: 'Password is not match');
      return false;
    }

    if (selectedGender.value == null) {
      Utils.showFailSnackBar(message: 'Please Choose Your Gender');
      return false;
    }

    return true;
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'required';
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
  }
}
