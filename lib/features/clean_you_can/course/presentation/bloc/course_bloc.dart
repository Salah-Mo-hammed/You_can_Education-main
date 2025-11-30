import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/usecases/get_course_details_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/presentation/bloc/course_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/presentation/bloc/course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  GetCourseDetailsUsecase getCourseDetailsUsecase;
  CourseBloc({required this.getCourseDetailsUsecase})
    : super(const CourseStateInitial()) {
    on<GetCourseDetailsEvent>(ongetCourseDetails);
  }

  FutureOr<void> ongetCourseDetails(
    GetCourseDetailsEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseStateLoading());
    final result = await getCourseDetailsUsecase.call(event.courseId);
    result.fold(
      (failure) {
        emit(CourseStateException(message: failure.message));
      },
      (courseEntity) {
        emit(CourseDetailsStateLoaded(courseEntity: courseEntity));
      },
    );
  }
}
