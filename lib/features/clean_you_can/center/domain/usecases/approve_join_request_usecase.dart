import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/repo/center_repo.dart';

class ApproveJoinRequestUsecase {
  CenterRepo centerRepo;
  ApproveJoinRequestUsecase({required this.centerRepo});
  Future<Either<Failure, void>> call(Map<String,dynamic> requestMap) {
    return centerRepo.approveJoinRequest(requestMap);
  }
}
