import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCourseDetailsEvent extends CourseEvent {
  final int courseId;
  GetCourseDetailsEvent({required this.courseId});

  @override
  List<Object?> get props => [courseId];
}
