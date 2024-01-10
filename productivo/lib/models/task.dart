import 'package:productivo/models/category.dart';

class Task {
  int id;
  String description;
  bool isCompleted;
  Category category;

  Task({
    required this.id,
    required this.description,
    this.isCompleted = false,
    required this.category,
  });

  // Mark the task as complete
  void completeTask() {
    isCompleted = true;
  }

  // Update the task description
  void updateDescription(String newDescription) {
    description = newDescription;
  }

  // Convert a Task object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'isCompleted': isCompleted,
      'category':
          category.toJson(), // Assuming Category also has a toJson method
    };
  }

  // Create a Task object from a JSON map
  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      category: Category.fromJson(
          json['category']), // Assuming Category has a fromJson method
    );
  }
}
