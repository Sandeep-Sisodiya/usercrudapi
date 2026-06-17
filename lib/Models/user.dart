class User {
  final String id;
  final String name;
  final int age;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['_id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      age: json['age'] ?? 0,
      role: (json['role'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'role': role,
    };
  }
}