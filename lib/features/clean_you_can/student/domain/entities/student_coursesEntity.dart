import 'package:equatable/equatable.dart';

class StudentCoursesEntity extends Equatable {
  final String courseId;
  final String status;
  final int progress;
  final Map<String, String> assignments;
  final String? result;
  StudentCoursesEntity({
    required this.courseId,
    required this.status,
    required this.progress,
    required this.assignments,
    this.result,
  });

  @override
  List<Object?> get props => [
    courseId,
    status,
    progress,
    assignments,
    result,
  ];
}
