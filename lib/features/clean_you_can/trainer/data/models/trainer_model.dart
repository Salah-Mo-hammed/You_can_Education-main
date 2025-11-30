import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

class TrainerModel extends TrainerEntity {
  TrainerModel({
    required super.uid,
    required super.name,
    required super.email,

    required super.phone,
    required super.imageUrl,
    required super.coursesId,
    required super.centerId,
  });

  Map<String, dynamic> toJson(String addgeneretedId) {
    return {
      'uid': addgeneretedId,
      'centerId': centerId,
      'name': name,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
      'coursesId': coursesId,
    };
  }

  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    return TrainerModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      imageUrl: json['imageUrl'] as String?,
      coursesId: List<String>.from(json['coursesId'] ?? []),
      centerId: json['centerId'] as String,
    );
  }
}
