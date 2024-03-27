import 'dart:core';

import 'package:flutter/cupertino.dart';

@immutable
final class Todo {
  final String? activity;
  final String? type;
  final int? participants;
  final double? price;
  final String? link;
  final String? key;
  final double? accessibility;
  final String? priority;
  final DateTime? deadline;
  final String? note;
  final bool? isDone;

  const Todo(
      {this.activity,
      this.type,
      this.participants,
      this.price,
      this.link,
      this.key,
      this.accessibility,
      this.priority,
      this.deadline,
      this.note,
      this.isDone});

  factory Todo.initial() => Todo(deadline: DateTime.now());

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      activity : json['activity'],
      type :json['type'],
      participants :json['participants'],
      price : json['price']?.toDouble(),
      link : json['link'],
      key :json['key'],
      accessibility : json['accessibility']?.toDouble(),
      priority : json['priority'],
      deadline : json['deadline'] != null ? DateTime.parse(json['deadline']) : DateTime.now(),
      note : json['note'],
      isDone : json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'type': type,
      'participants': participants,
      'price': price,
      'link': link,
      'key': key,
      'accessibility': accessibility,
      'priority': priority,
      'deadline': deadline?.toIso8601String(),
      'note': note,
      'isDone': isDone,
    };
  }

  Todo copyWith({
    String? activity,
    String? type,
    int? participants,
    double? price,
    String? link,
    String? key,
    double? accessibility,
    String? priority,
    DateTime? deadline,
    String? note,
    bool? isDone,
  }) {
    return Todo(
      activity: activity ?? this.activity,
      type: type ?? this.type,
      participants: participants ?? this.participants,
      price: price ?? this.price,
      link: link ?? this.link,
      key: key ?? this.key,
      accessibility: accessibility ?? this.accessibility,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
      note: note ?? this.note,
      isDone: isDone ?? this.isDone,
    );
  }

}
