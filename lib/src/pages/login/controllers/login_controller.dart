import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/common/utils.dart';
import '../../../infrastructure/routes/route_names.dart';
import '../repositories/login_repository.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final _repository = LoginRepository();

  final RxBool isRemember = false.obs;
  final RxBool isVisible = false.obs;

  void rememberToggle(bool? value) {
    isRemember.value = value ?? false;
  }

  //* Loging in ---------------------------------------------------

  Future<void> onLogin() async {
    if (!formValidation()) return;

    final result = await _repository.login(
      username: userController.text,
      password: passController.text,
    );

    result.fold(
      (exception) {
        Utils.showFailSnackBar(message: exception);
      },
      (user) {
        // got user info at server
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

  bool formValidation() {
    if (!(formKey.currentState?.validate() ?? false)) return false;
    return true;
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'required';
    return null;
  }
}
