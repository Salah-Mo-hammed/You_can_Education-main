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