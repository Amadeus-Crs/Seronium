class Post {
  final int id;
  final int userId;
  final String title;
  final String content;
  final String type; // "question" or "article"
  final String status;
  final int viewCount;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.type,
    required this.status,
    required this.viewCount,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['ID'],
      userId: json['UserID'],
      title: json['Title'],
      content: json['Content'],
      type: json['Type'],
      status: json['Status'],
      viewCount: json['ViewCount'] ?? 0,
      createdAt: DateTime.parse(json['CreatedAt']),
    );
  }
}