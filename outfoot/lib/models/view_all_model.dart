class Goal {
  final int total;
  final int checkPages;

  Goal({
    required this.total,
    required this.checkPages,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      total: json['total'] ?? 0,
      checkPages: json['checkPages'] ?? 0,
    );
  }
}
