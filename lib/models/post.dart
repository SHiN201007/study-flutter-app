

class Post {
  final String id;
  final String authorId;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Post({
    required this.id,
    required this.authorId,
    this.imageUrl,
    this.createdAt,
    this.updatedAt
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      authorId: json['authorId'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Post copyWith({
    String? imageUrl,
  }) {
    return Post(
      id: id,
      authorId: authorId,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: DateTime.now(),
    );
  }
}