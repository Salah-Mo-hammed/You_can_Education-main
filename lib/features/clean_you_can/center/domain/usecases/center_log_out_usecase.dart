import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/repo/center_repo.dart';

class LogOutCenterUseCases {
  CenterRepo centerRepo;
  LogOutCenterUseCases({required this.centerRepo});
  Future<Either<Failure, Unit>> call() {
    return centerRepo.logOutCenter();
  }
}
