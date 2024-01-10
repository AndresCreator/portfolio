import 'package:divido/domain/entities/friend.entity.dart';

class Expense {
  final String id;
  final String title;
  final String description;
  final double value;
  final DateTime date;
  final Friend friend;
  final int percentage;

  Expense(
      {required this.id,
      required this.title,
      required this.description,
      required this.value,
      required this.date,
      required this.friend,
      this.percentage = 50});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'value': value,
      'date': date,
      'friend': friend.toMap(),
      'percentage': percentage,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      value: map['value'],
      date: map['date'],
      friend: Friend.fromMap(map['friend']),
      percentage: map['percentage'] ?? 50,
    );
  }
}
