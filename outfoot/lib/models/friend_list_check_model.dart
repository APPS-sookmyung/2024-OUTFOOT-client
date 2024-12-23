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
      id: json['id'] as int,
      nickname: json['nickname'] as String,
      intro: json['intro'] as String? ?? '',
    );
  }
}

class FriendListResponse {
  final bool success;
  final int total;
  final List<Friend> friendLists;

  FriendListResponse({
    required this.success,
    required this.total,
    required this.friendLists,
  });

  factory FriendListResponse.fromJson(Map<String, dynamic> json) {
    return FriendListResponse(
      success: json['success'] as bool,
      total: json['response']['total'] as int,
      friendLists: (json['response']['friendLists'] as List)
          .map((item) => Friend.fromJson(item))
          .toList(),
    );
  }
}
