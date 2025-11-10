import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

abstract class CenterTrainerEvent {}

class FetchCenterTrainers extends CenterTrainerEvent {
  final String centerId;
  FetchCenterTrainers({required this.centerId});
}
class CreateTrainerEvent extends CenterTrainerEvent{
  TrainerEntity newTrainer;
  String password;
  CreateTrainerEvent({required this.newTrainer,required this.password});
}
class CenterLogOutTrainerPartEvent extends CenterTrainerEvent {
  CenterLogOutTrainerPartEvent();
}
/*
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/entities/center_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';

abstract class CenterEvent {}

class CreateCenterEvent extends CenterEvent {
  CenterEntity createCenter;
  CreateCenterEvent({required this.createCenter});
}

class AddCourseEvent extends CenterEvent {
  CourseEntity addCourseEntity;
  AddCourseEvent({required this.addCourseEntity});
}
class DeleteCourseEvent extends CenterEvent {
  String courseId;
  DeleteCourseEvent({required this.courseId});
}
class UpdateCourseEvent extends CenterEvent {
  CourseEntity updateCourseEntity;
  UpdateCourseEvent({required this.updateCourseEntity});
}

class GetCenterCoursesEvent extends CenterEvent {
  String centerId;
  GetCenterCoursesEvent({required this.centerId});
}
class FetchCenterTrainers extends CenterEvent{
final String centerId;
 FetchCenterTrainers({required this.centerId});
}
 */