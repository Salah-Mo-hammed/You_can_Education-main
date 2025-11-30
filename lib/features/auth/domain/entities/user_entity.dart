class UserEntity {
  String uid;
  String role;
  String email;
  bool isVerified;
  bool? isCompletedInfo;
  UserEntity({required this.isCompletedInfo,
    required this.role,
    required this.email,
    required this.uid,
    required this.isVerified,
  });
}
