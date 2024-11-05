class Goal {
  final int id;
  final String title;
  final String intro;
  final String createdAt;
  final int animalPosition;
  final String animal; 
  final List<ConfirmResponse> confirmResponses;

  Goal({
    required this.id,
    required this.title,
    required this.intro,
    required this.createdAt,
    required this.animalPosition,
    required this.animal,
    required this.confirmResponses,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    var confirmResponsesFromJson = json['confirmResponses'] as List;
    List<ConfirmResponse> confirmResponsesList =
        confirmResponsesFromJson.map((i) => ConfirmResponse.fromJson(i)).toList();
        
    return Goal(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      intro: json['intro'] ?? '',
      createdAt: json['createdAt'] ?? '',
      animalPosition: json['animalPosition'] ?? 0,
      animal: json['animal'] ?? '',
      confirmResponses: confirmResponsesList,
    );
  }
}

class ConfirmResponse {
  final int id;
  final String imageUrl;

  ConfirmResponse({
    required this.id,
    required this.imageUrl,
  });

  factory ConfirmResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmResponse(
      id: json['id'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}