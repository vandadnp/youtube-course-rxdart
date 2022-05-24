import 'package:flutter/material.dart' show BuildContext;
import 'package:testingrxdart_course/dialogs/generic_dialog.dart';

Future<bool> showDeleteContactDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete contact',
    content:
        'Are you sure you want to delete this contact? You cannot undo this operation!',
    optionsBuilder: () => {
      'Cancel': false,
      'Delete contact': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
