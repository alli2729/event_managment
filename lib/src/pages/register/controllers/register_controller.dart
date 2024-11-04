import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart';
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
  RxBool isVisible = false.obs;
  RxBool isLoading = false.obs;

  void selectGender(String? gender) {
    selectedGender.value = gender!;
  }

  //* registration --------------------------------------

  void onRegister() => checkUserExist();

  Future<void> checkUserExist() async {
    if (!isFormValidate()) return;
    isLoading.value = true;

    final result = await _repository.chekUserExist(
      username: usernameController.text,
    );

    result.fold(
      (code) {
        Utils.showFailSnackBar(message: exception(code));
        isLoading.value = false;
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
      bookmarked: [],
    );

    final result = await _repository.registerByDto(dto: dto);

    result.fold(
      (code) {
        Utils.showFailSnackBar(message: exception(code));
        isLoading.value = false;
      },
      (success) {
        isLoading.value = false;
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
      Utils.showFailSnackBar(
          message: LocaleKeys
              .event_managment_app_register_page_password_not_match.tr);
      return false;
    }

    if (selectedGender.value == null) {
      Utils.showFailSnackBar(
          message:
              LocaleKeys.event_managment_app_register_page_choose_gender.tr);
      return false;
    }

    return true;
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.event_managment_app_register_page_required.tr;
    }
    return null;
  }

  String? userValidate(String? value) {
    if (value == null || value.length < 6) {
      return LocaleKeys.event_managment_app_register_page_longer_than_6.tr;
    }
    if (value.contains(' ')) {
      return LocaleKeys.event_managment_app_register_page_no_space.tr;
    }
    return null;
  }

  String? passValidate(String? value) {
    if (value == null || value.length < 8) {
      return LocaleKeys.event_managment_app_register_page_longer_than_8.tr;
    }
    if (value.contains(' ')) {
      return LocaleKeys.event_managment_app_register_page_no_space.tr;
    }
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

  String exception(int code) {
    switch (code) {
      case 1:
        return LocaleKeys.event_managment_app_register_page_error.tr;
      case 2:
        return LocaleKeys
            .event_managment_app_register_page_somthing_went_wrong.tr;
      case 3:
        return LocaleKeys
            .event_managment_app_register_page_username_already_taken.tr;
      default:
        return '';
    }
  }
}
