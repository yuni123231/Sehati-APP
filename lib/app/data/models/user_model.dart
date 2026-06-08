class User {
  final String name;
  final String email;
  final String? password; // password bisa null

  User({
    required this.name,
    required this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      if (password != null) 'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      // Jangan ambil password dari json untuk keamanan
      password: null,
    );
  }
}
