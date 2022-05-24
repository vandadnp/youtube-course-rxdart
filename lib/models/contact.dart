import 'package:flutter/foundation.dart' show immutable;
import 'package:uuid/uuid.dart';

@immutable
class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  const Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  Contact.withoutId({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  }) : id = const Uuid().v4();

  Contact.fromJson(
    Map<String, dynamic> json, {
    required this.id,
  })  : firstName = json[_Keys.firstNameKey] as String,
        lastName = json[_Keys.lastNameKey] as String,
        phoneNumber = json[_Keys.phoneNumberKey] as String;

  String get fullName => '$firstName $lastName';
}

extension Data on Contact {
  Map<String, dynamic> get data => {
        _Keys.firstNameKey: firstName,
        _Keys.lastNameKey: lastName,
        _Keys.phoneNumberKey: phoneNumber,
      };
}

@immutable
class _Keys {
  const _Keys._();
  static const firstNameKey = 'first_name';
  static const lastNameKey = 'last_name';
  static const phoneNumberKey = 'phone_number';
}
