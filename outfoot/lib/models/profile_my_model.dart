class Profile {
  final int id;
  final String name;
  final String myIntro;
  final String imageUrl;
  final int friendCount;
  final String code;

  Profile({
    required this.id,
    required this.name,
    required this.myIntro,
    required this.imageUrl,
    required this.friendCount,
    required this.code,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      myIntro: json['myIntro'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      friendCount: json['friendCount'] ?? 0,
      code: json['code'] ?? '',
    );
  }
}
