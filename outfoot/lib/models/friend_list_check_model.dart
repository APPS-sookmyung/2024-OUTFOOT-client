class Friend {
  final int id;
  final String nickname;
  final String intro;

  Friend({
    required this.id,
    required this.nickname,
    required this.intro,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'] ?? 0,
      nickname: json['nickname'] ?? '',
      intro: json['intro'] ?? '',
    );
  }
}

class FriendListResponse {
  final int total;
  final List<Friend> friendLists;

  FriendListResponse({
    required this.total,
    required this.friendLists,
  });

  factory FriendListResponse.fromJson(Map<String, dynamic> json) {
    return FriendListResponse(
      total: json['total'] ?? 0,
      friendLists: (json['friendLists'] as List<dynamic>)
          .map((item) => Friend.fromJson(item))
          .toList(),
    );
  }
}
