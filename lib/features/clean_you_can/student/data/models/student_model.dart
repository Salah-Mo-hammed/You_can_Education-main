import 'package:grad_project_ver_1/features/clean_you_can/student/data/models/student_courses_model.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';

// ignore: must_be_immutable
class StudentModel extends StudentEntity {
  StudentModel({
    required super.studentId,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.address,
    required super.photoUrl,
    super.courses,
    //  required super.registerdCourses,
  });

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'photoUrl': photoUrl,
      'courses': courses!.map(
        (key, value) =>
            MapEntry(key, (value as StudentCoursesModel).toJson()),
      ),
      //  'registerdCourses': registerdCourses,
    };
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentId: json['studentId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      photoUrl: json['photoUrl'] as String?,
      courses: (json['courses'] as Map<String, dynamic>? ?? {}).map(
        (key, value) =>
            MapEntry(key, StudentCoursesModel.fromJson(value)),
      ),
      //     registerdCourses: List<String>.from(json['registerdCourses'] ?? []),
    );
  }
}
