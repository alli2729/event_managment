import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart';
import '../../../infrastructure/routes/route_names.dart';
import '../repositories/login_repository.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final _repository = LoginRepository();

  final RxBool isRemember = false.obs;
  final RxBool isVisible = false.obs;
  final RxBool isLoading = false.obs;

  void rememberToggle(bool? value) {
    isRemember.value = value ?? false;
  }

  //* Loging in ---------------------------------------------------

  Future<void> onLogin() async {
    if (!formValidation()) return;
    isLoading.value = true;

    final result = await _repository.login(
      username: userController.text,
      password: passController.text,
    );

    result.fold(
      (number) {
        Utils.showFailSnackBar(message: exception(number));
        isLoading.value = false;
      },
      (user) {
        isLoading.value = false;
        // got user info from server
        Get.offNamed(
          RouteNames.events,
          parameters: {"userId": '${user["id"]}'},
        );
      },
    );
  }

  Future<void> onRegister() async {
    final result = await Get.toNamed(RouteNames.register);
    if (result != null) {
      userController.text = result["username"];
      passController.text = result["password"];
    }
  }

  //* Validations ----------------------------------------------------

  bool formValidation() =>
      (!(formKey.currentState?.validate() ?? false)) ? false : true;

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.event_managment_app_login_page_required.tr;
    }
    if (value.contains(' ')) {
      return LocaleKeys.event_managment_app_login_page_no_space.tr;
    }
    return null;
  }

  String exception(int number) {
    switch (number) {
      case 1:
        return LocaleKeys.event_managment_app_login_page_user_not_found.tr;
      case 2:
        return LocaleKeys.event_managment_app_login_page_password_incorrect.tr;
      case 3:
        return LocaleKeys.event_managment_app_login_page_somthing_went_wrong.tr;
      default:
        return '';
    }
  }
}
