import 'package:grad_project_ver_1/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.uid,
    required super.isVerified, required super.role,  super.isCompletedInfo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      uid: json['uid'],
      isVerified: json['isVerified'], role: json['role']?? 'student', isCompletedInfo: json['isCompletedInfo']?? false ,//default be student
    );
  }
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'isVerified': isVerified,'role':role};
  }
}
