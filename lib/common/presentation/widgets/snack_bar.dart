import 'package:flutter/material.dart';

import '../../../theme/theme_ext.dart';

abstract class AppSnackBar {
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(backgroundColor: context.colors.error, content: Text(message)),
      );
  }
}
