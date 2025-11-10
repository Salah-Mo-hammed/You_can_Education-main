import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/repo/center_repo.dart';

class AddCourseSessionUsecase {
  final CenterRepo centerRepo;
  AddCourseSessionUsecase({required this.centerRepo});
  Future<Either<Failure,String>> call(String courseId,String sessionTitle, String sessionUrl){
    return centerRepo.addCourseSession(courseId,sessionTitle,sessionUrl);
  }
}