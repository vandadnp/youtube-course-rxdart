import 'package:flutter/material.dart';
import 'package:testingrxdart_course/blocs/auth_bloc/auth_error.dart';
import 'package:testingrxdart_course/dialogs/generic_dialog.dart';

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) =>
    showGenericDialog(
      context: context,
      title: authError.dialogTitle,
      content: authError.dialogText,
      optionsBuilder: () => {
        'OK': true,
      },
    );
