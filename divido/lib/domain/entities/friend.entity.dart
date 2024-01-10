class Friend {
  final String name;
  final String phone;

  Friend({required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      name: map['name'],
      phone: map['phone'],
    );
  }
}
