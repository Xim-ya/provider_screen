import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BaseViewModel() {
    onInit();
  }

  late BuildContext context;

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @protected
  void onInit() {}

  @protected
  void onDispose() {}

  void initContext(BuildContext contextArg) {
    context = contextArg;
  }
}
