class FriendResponse {
  final String status; // '200' 또는 오류 코드
  final String message; // 상태에 따른 메시지
  final String? errorCode; // 오류 코드 (있을 경우)

  FriendResponse({
    required this.status,
    required this.message,
    this.errorCode,
  });

  // JSON 데이터를 받아서 FriendResponse 객체를 생성하는 팩토리 생성자
  factory FriendResponse.fromJson(Map<String, dynamic> json) {
    return FriendResponse(
      status: json['status'] ?? 'unknown',
      message: json['message'] ?? '알 수 없는 오류가 발생했습니다.',
      errorCode: json['error'], // 오류 코드가 없으면 null
    );
  }

  // FriendResponse 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      if (errorCode != null) 'error': errorCode,
    };
  }
}
