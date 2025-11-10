import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/repo/course_repo.dart';

class GetCourseDetailsUsecase {
  final CourseRepo courseRepo;
  GetCourseDetailsUsecase({required this.courseRepo});
  Future<Either<Failure, CourseEntity>> call(int courseId) {
    return courseRepo.getCourseDetails(courseId);
  }
}
