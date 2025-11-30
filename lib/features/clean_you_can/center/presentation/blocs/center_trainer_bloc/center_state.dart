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