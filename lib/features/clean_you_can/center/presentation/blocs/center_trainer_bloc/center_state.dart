import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

abstract class CenterTrainerState {
  List<TrainerEntity>? currenttrainers;
   CenterTrainerState({this .currenttrainers});
}

class CenterTrainerInitialState extends CenterTrainerState {
   CenterTrainerInitialState();
}
class CenterTrainerCreatedState extends CenterTrainerState {
  String newTrainerUid;
  CenterTrainerCreatedState({required this.newTrainerUid});
}


class CenterTrainerLoadingState extends CenterTrainerState {}

class CenterGotTrainersState extends CenterTrainerState {
  List<TrainerEntity> trainers;
  CenterGotTrainersState({required this.trainers});
}

class CenterTrainerExceptionState extends CenterTrainerState {
  final String message;
  CenterTrainerExceptionState({required this.message});
}
/*
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

abstract class CenterState {
  const CenterState();
}

class CenterInitialState extends CenterState {
  const CenterInitialState();
}

class CenterCreatedState extends CenterState {}

class CenterLoadingState extends CenterState {}


class CenterAddedCourseState extends CenterState {
  CourseEntity courseEntity;
  CenterAddedCourseState({required this.courseEntity});
}
class CenterUpdatedCourseState extends CenterState {}


class CenterExceptionState extends CenterState {
  final String message;
  CenterExceptionState({required this.message});
}

class CenterGotCoursesState extends CenterState {
  List<CourseEntity> courses;
  CenterGotCoursesState({required this.courses});
}


class CenterGotTrainersState extends CenterState {
  List<TrainerEntity> trainers;
  CenterGotTrainersState({required this.trainers});
}


 */