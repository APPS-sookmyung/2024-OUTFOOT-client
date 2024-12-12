class AddGoal {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final int likeCount;
  final int dislikeCount;
  final String imageUrl;

  AddGoal({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.dislikeCount,
    required this.imageUrl,
  });

  factory AddGoal.fromJson(Map<String, dynamic> json) {
    return AddGoal(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['createdAt'] ?? '',
      likeCount: json['likeCount'] ?? 0,
      dislikeCount: json['dislikeCount'] ?? 0,
      imageUrl: json['image'] ?? '',
    );
  }
}
