import 'package:equatable/equatable.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';

abstract class CourseState extends Equatable {
  const CourseState();
  @override
  List<Object?> get props => [];
}

class CourseStateInitial extends CourseState {
  const CourseStateInitial();
}

class CourseStateLoading extends CourseState {}

class CourseDetailsStateLoaded extends CourseState {
  final CourseEntity courseEntity;
  const CourseDetailsStateLoaded({required this.courseEntity});
  @override
  List<Object?> get props => [courseEntity];
}

class CourseStateException extends CourseState {
  final String message;
  const CourseStateException({required this.message});
  @override
  List<Object?> get props => [message];
}
