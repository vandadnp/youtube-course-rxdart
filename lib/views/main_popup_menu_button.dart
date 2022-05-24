import 'package:flutter/material.dart';
import 'package:testingrxdart_course/dialogs/delete_account_dialog.dart';
import 'package:testingrxdart_course/dialogs/logout_dialog.dart';
import 'package:testingrxdart_course/type_definitions.dart';

enum MenuAction { logout, deleteAccount }

class MainPopupMenuButton extends StatelessWidget {
  final LogoutCallback logout;
  final DeleteAccountCallback deleteAccount;

  const MainPopupMenuButton({
    Key? key,
    required this.logout,
    required this.deleteAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (value) async {
        switch (value) {
          case MenuAction.logout:
            final shouldLogout = await showLogoutDialog(context);
            if (shouldLogout) {
              logout();
            }
            break;
          case MenuAction.deleteAccount:
            final shouldDeleteAccount = await showDeleteAccountDialog(context);
            if (shouldDeleteAccount) {
              deleteAccount();
            }
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text(
              'Log out',
            ),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.deleteAccount,
            child: Text(
              'Delete account',
            ),
          ),
        ];
      },
    );
  }
}
