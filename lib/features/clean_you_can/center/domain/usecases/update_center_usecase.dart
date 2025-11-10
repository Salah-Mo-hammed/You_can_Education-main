import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/entities/center_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/repo/center_repo.dart';

class UpdatedCenterInfoUsecase {
  CenterRepo centerRepo;
  UpdatedCenterInfoUsecase({required this.centerRepo});
  Future<Either<Failure, void>> call(CenterEntity updatedCenter) {
    return centerRepo.updateCenterInfo(updatedCenter);
  }
}
