import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

abstract class TrainerState  {
  const TrainerState();
}

class TrainerLoadingState extends TrainerState {}

class TrainerInitialState extends TrainerState {}

class TrainerGotHisCoursesState extends TrainerState {
  Map<String,dynamic> trainerCourses;
  TrainerGotHisCoursesState({required this.trainerCourses});
}

class TrainerGotHisInfoState extends TrainerState {
  TrainerEntity trainer;
  TrainerGotHisInfoState({required this.trainer});
}
class TrainerExceptionState extends TrainerState {
  final String errorMessage;
  TrainerExceptionState({required this.errorMessage});
}
