class Category {
  int id;
  String name;

  Category({required this.id, required this.name});

  // Convert a Category object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Create a Category object from a JSON map
  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  // Additional methods or functionality specific to a category can be added here.
}
