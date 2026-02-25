class User {
  final int id;
  final String username;
  final String bio;
  final String avatarUrl;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.bio,
    required this.avatarUrl,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['ID']??0,
      username: json['Username']??'',
      bio: json['Bio'] ?? '',
      avatarUrl: json['AvatarURL']??'',
      token: json['token']??'',
    );
  }
}