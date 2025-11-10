import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/repo/center_repo.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

class FetchCenterTrainersUsecase {
  CenterRepo centerRepo;
  FetchCenterTrainersUsecase({required this.centerRepo});
  Future<Either<Failure,List<TrainerEntity>>> call(String centerId){
    return centerRepo.fetchCenterTrainers(centerId);
  }
}