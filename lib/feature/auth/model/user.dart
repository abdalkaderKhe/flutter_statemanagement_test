import 'package:flutter/foundation.dart';

@immutable
final class User {
  final String name;

  const User({required this.name});

  User copyWith({String? name}) {
    return User(
      name: name ?? this.name,
    );
  }

  factory User.initial() => const User(name: '');
}
