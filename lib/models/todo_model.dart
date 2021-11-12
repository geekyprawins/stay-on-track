import 'package:flutter/material.dart';

@immutable
class TodoModel {
  const TodoModel({
    this.text = '',
    required this.dueDate,
    this.priority = 3,
    this.isDone = false,
  });

  final String text;
  final DateTime dueDate;
  final int priority;
  final bool isDone;

  TodoModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        dueDate = DateTime.parse(json['dueDate']),
        priority = int.parse(json['priority']),
        isDone = json['isDone'].toLowerCase() == true.toString().toLowerCase();

  Map<String, dynamic> toJson() => {
        'text': text,
        'dueDate': dueDate.toIso8601String(),
        'priority': priority.toString(),
        'isDone': isDone.toString(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModel &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          dueDate.isAtSameMomentAs(other.dueDate) &&
          priority == other.priority;

  @override
  int get hashCode =>
      {text + dueDate.toIso8601String() + priority.toString()}.hashCode;

  TodoModel copyWith({
    String? text,
    DateTime? dueDate,
    int? priority,
    bool? isDone,
  }) {
    return TodoModel(
      text: text ?? this.text,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
    );
  }
}
