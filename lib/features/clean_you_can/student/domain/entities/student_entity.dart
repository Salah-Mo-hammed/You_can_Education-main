import 'package:equatable/equatable.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_coursesEntity.dart';

// ignore: must_be_immutable
class StudentEntity extends Equatable {
  String studentId;
  String name;
  String email;
  String phoneNumber;
  String address;
  String? photoUrl;
  //List<String> registerdCourses;
  Map<String,StudentCoursesEntity>? courses;

  StudentEntity({
    required this.studentId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
     this.courses,
     this.photoUrl,
//    this.registerdCourses = const [],
  });

  @override
  List<Object?> get props => [
    studentId,
    name,
    phoneNumber,
    address,
    photoUrl,
    courses,
//    registerdCourses,
  ];
}
