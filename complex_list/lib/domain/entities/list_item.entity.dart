class ListItem {
  final int? id;
  final String title;
  final String description;
  final bool isDone;

  ListItem({
    this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  ListItem copyWith({
    String? title,
    String? description,
    bool? isDone,
    int? id,
  }) {
    return ListItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone ? 1 : 0,
    };
  }
}
