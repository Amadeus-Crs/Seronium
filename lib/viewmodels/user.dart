class User {
  final int id;
  final String username;
  final String bio;
  final String? avatarUrl;

  User({
    required this.id,
    required this.username,
    required this.bio,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']??'',
      username: json['username']??'',
      bio: json['bio'] ?? '',
      avatarUrl: json['avatar_url']??'',
    );
  }
}