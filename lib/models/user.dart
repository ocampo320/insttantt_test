class User {
  final String username;
  final String password;
  final String email;
  final String? imagePath;

  User(
      {required this.username,
      required this.password,
      required this.email,
      this.imagePath});
  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        username: json['username'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        imagePath: json['imagePath'] ?? '');
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'imagePath': imagePath,
    };
  }
}
