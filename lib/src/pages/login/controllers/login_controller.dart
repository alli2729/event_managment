import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../generated/locales.g.dart';
import '../../../../localization_service.dart';
import '../../../infrastructure/utils/utils.dart';
import '../../../infrastructure/routes/route_names.dart';
import '../repositories/login_repository.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final _repository = LoginRepository();
  final _box = GetStorage();

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
      (exception) {
        Utils.showFailSnackBar(message: exception.tr);
        isLoading.value = false;
      },
      (user) async {
        isLoading.value = false;

        // writing user info to local storage
        if (isRemember.value == true) {
          await _box.write(
            'credential',
            {
              "username": userController.text,
              "password": passController.text,
              "userId": user["id"],
            },
          );
        }

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

  void onChangeLanguage() => LocalizationService.changeLang();

  Future<void> readData() async {
    final Map? cred = _box.read('credential');
    if (cred == null) return;
    final int userId = await cred["userId"];

    await Get.offNamed(
      RouteNames.events,
      parameters: {"userId": '$userId'},
    );
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

  @override
  void onInit() {
    super.onInit();
    readData();
  }
}
