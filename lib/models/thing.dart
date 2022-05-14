import 'package:flutter/foundation.dart' show immutable;

@immutable
class Thing {
  final String name;
  const Thing({
    required this.name,
  });
}
