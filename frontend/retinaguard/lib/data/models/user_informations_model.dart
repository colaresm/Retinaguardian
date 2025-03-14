class UserInformationsModel {
  final String userId;
  final String accessToken;

  UserInformationsModel({required this.userId, required this.accessToken});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'access_token': accessToken,
    };
  }

  factory UserInformationsModel.fromJson(Map<String, dynamic> json) {
    return UserInformationsModel(
      userId: json['user_id'] as String,
      accessToken: json['access_token'] as String,
    );
  }
}
