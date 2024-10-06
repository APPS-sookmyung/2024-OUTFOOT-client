class Goal {
  final int id;
  final String title;
  final String intro;
  final String createdAt;
  final int animalPosition;
  final String animal;

  Goal({
    required this.id,
    required this.title,
    required this.intro,
    required this.createdAt,
    required this.animalPosition,
    required this.animal,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      intro: json['intro'] ?? '',
      createdAt: json['createdAt'] ?? '',
      animalPosition: json['animalPosition'] ?? 0,
      animal: json['animal'] ?? '',
    );
  }
}
