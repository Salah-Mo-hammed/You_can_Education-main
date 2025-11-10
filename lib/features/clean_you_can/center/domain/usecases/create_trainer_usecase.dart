import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/repo/center_repo.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

class CreateTrainerUsecase {
  CenterRepo centerRepo;
  CreateTrainerUsecase({required this.centerRepo});
  Future<Either<Failure,String>> call(TrainerEntity newTrainer,String password)  {
   return centerRepo.createTrainer(newTrainer,password);
  }
}