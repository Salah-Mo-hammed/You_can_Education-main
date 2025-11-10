part of 'center_courses_bloc.dart';

sealed class CenterCoursesState {
  const CenterCoursesState();
}

class CenterCoursesInitial extends CenterCoursesState {}

class CenterAddedCourseState extends CenterCoursesState {
  CourseEntity courseEntity;
  CenterAddedCourseState({required this.courseEntity});
}

class CenterUpdatedCourseState extends CenterCoursesState {
  final String updated;
  CenterUpdatedCourseState({required this.updated});
}

class CenterdeletedCourseState extends CenterCoursesState {
  final String deleted;
  CenterdeletedCourseState({required this.deleted});
}

class CenterCoursesExceptionState extends CenterCoursesState {
  final String message;
  CenterCoursesExceptionState({required this.message});
}
class CenterCourseAddedSession extends CenterCoursesState {
  final String successMessage;
  CenterCourseAddedSession({required this.successMessage});
}
class CenterCoursesLoadingState extends CenterCoursesState {}

class CenterGotCoursesState extends CenterCoursesState {
  List<CourseEntity> courses;
  CenterGotCoursesState({required this.courses});
}


/*
class AddCourseEvent extends CenterCoursesEvent {
  CourseEntity addCourseEntity;
  AddCourseEvent({required this.addCourseEntity});
  
}
class DeleteCourseEvent extends CenterCoursesEvent {
  String courseId;
  DeleteCourseEvent({required this.courseId});
}
class UpdateCourseEvent extends CenterCoursesEvent {
  CourseEntity updateCourseEntity;
  UpdateCourseEvent({required this.updateCourseEntity});
}

class GetCenterCoursesEvent extends CenterCoursesEvent {
  String centerId;
  GetCenterCoursesEvent({required this.centerId});
}
 */