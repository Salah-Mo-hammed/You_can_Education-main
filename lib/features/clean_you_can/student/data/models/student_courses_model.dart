import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_coursesEntity.dart';

class StudentCoursesModel extends StudentCoursesEntity {
  StudentCoursesModel({
    required super.courseId,
    required super.status,
    required super.progress,
    required super.assignments,
    super.result,
  });

  Map<String, dynamic> toJson() => {
    'courseId': courseId,
    'status': status,
    'progress': progress,
    'assignments': assignments,
    'result': result,
  };
  factory StudentCoursesModel.fromJson(Map<String, dynamic> json) =>
      StudentCoursesModel(
        courseId: json['courseId'],
        status: json['status'],
        progress: json['progress'],
        assignments: Map<String, String>.from(json['assignments']),
        result: json['result'],
      );
}
