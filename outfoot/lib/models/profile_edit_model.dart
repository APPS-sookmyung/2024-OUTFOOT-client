class ProfileEditResponse {
  final bool success;
  final ProfileData? response;
  final String? message;

  ProfileEditResponse({
    required this.success,
    this.response,
    this.message,
  });

  factory ProfileEditResponse.fromJson(Map<String, dynamic> json) {
    return ProfileEditResponse(
      success: json['success'] ?? false,
      response: json['response'] != null
          ? ProfileData.fromJson(json['response'])
          : null,
      message: json['message'],
    );
  }
}

class ProfileData {
  final String nickname;
  final String myIntro;
  final String email;
  final String? imageUrl;

  ProfileData({
    required this.nickname,
    required this.myIntro,
    required this.email,
    this.imageUrl,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      nickname: json['nickname'],
      myIntro: json['myIntro'],
      email: json['email'],
      imageUrl: json['imageUrl'],
    );
  }
}
