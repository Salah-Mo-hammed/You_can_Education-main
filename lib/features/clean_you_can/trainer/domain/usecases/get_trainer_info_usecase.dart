import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/repo/trianer_repo.dart';

class GetTrainerInfoUsecase {
  TrianerRepo trianerRepo;
  GetTrainerInfoUsecase({required this.trianerRepo});
  Future<Either<Failure,TrainerEntity>>call(String trainerId){
    return trianerRepo.getTraienrInfo(trainerId);
  }

}