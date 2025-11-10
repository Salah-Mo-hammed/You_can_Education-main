import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/repo/center_repo.dart';

class GetCenterRequestsUsecase {
  CenterRepo centerRepo;
  GetCenterRequestsUsecase({required this.centerRepo});
  Future<Either<Failure, List<Map<String, dynamic>>>> call(String centerId){
    return centerRepo.getCenterRequests(centerId);
  }
}