import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoader {
  static final EasyLoader _singleton = EasyLoader._internal();

  factory EasyLoader() {
    return _singleton;
  }

  EasyLoader._internal();

  //EasyLoader._();

  void addLoader({bool isLoaderNeeded = true}) {
    if (!isLoaderNeeded) return;

    EasyLoading.show(status: 'Please Wait ....');
    EasyLoading.instance.userInteractions = false;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
    EasyLoading.instance.backgroundColor = Colors.transparent;
  }

// it is used to remove loader
  void removeLoader() {
    EasyLoading.dismiss();
  }
}
