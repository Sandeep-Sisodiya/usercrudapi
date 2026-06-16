class User{
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
      id: json['id'],
      name: json['name'],
      age: json['age'],
      role: json['role'],
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
