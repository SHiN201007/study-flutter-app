class User {
  final String id;
  final String handle;
  final String name;
  final int followersCount;
  final int followingCount;
  final bool isFollowing;

  const User({
    required this.id,
    required this.handle,
    required this.name,
    required this.followersCount,
    required this.followingCount,
    required this.isFollowing,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      handle: json['handle'],
      name: json['name'],
      followersCount: json['followers_count'],
      followingCount: json['following_count'],
      isFollowing: json['is_following'],
    );
  }

  User copyWith({
    String? handle,
    String? name,
    int? followersCount,
    int? followingCount,
    bool? isFollowing,
  }) {
    return User(
      id: id,
      handle: handle ?? this.handle,
      name: name ?? this.name,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}
