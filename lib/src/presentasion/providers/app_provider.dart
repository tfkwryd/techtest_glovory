import 'package:flutter/material.dart';
import 'package:techtest/src/core/constants/storage_constants.dart';
import 'package:techtest/src/core/utils/toast_utils.dart';
import 'package:techtest/src/data/datasource/local/shared_preference_storage.dart';
import 'package:techtest/src/domain/datasources/local/local_storage.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    checkStatusApp();
  }

  final LocalStorage _localStorage = SharedPreferenceStorage();
  bool isLoading = false;
  bool isFirstOpenApp = false;

  void checkStatusApp() async {
    isLoading = true;
    notifyListeners();
    await checkIsFirstOpen();
    isLoading = false;
    notifyListeners();
  }

  Future<void> checkIsFirstOpen() async {
    isLoading = true;
    notifyListeners();
    try {
      final bool? _isFirstOpenApp = await _localStorage.getBool(
        index: StorageConstants.isFirstOpenApp,
      );
      if (_isFirstOpenApp == null || _isFirstOpenApp) {
        isFirstOpenApp = true;
      }
    } catch (e) {
      Toast.show(message: e.toString(), toastType: ToastType.error);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> setIsFirstOpen({required bool status}) async {
    isLoading = true;
    notifyListeners();
    try {
      await _localStorage.setBool(
          index: StorageConstants.isFirstOpenApp, value: status);
      isFirstOpenApp = status;
    } catch (e) {
      Toast.show(message: e.toString(), toastType: ToastType.error);
    }
    isLoading = false;
    notifyListeners();
  }
}
