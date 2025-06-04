class Todo {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
