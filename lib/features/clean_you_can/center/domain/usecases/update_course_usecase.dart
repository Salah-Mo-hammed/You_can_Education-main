import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/repo/center_repo.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';

class UpdateCourseUsecase {
  CenterRepo centerRepo;
  UpdateCourseUsecase({required this.centerRepo});
  Future<Either<Failure, String>> call(CourseEntity courseEntity) {
    return centerRepo.updateCourse(courseEntity);
  }
}
