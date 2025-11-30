import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/repo/center_repo.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';

class GetCourseStudents {
  CenterRepo centerRepo;
  GetCourseStudents({required this.centerRepo});
  Future<Either<Failure, List<StudentEntity>>> call(int courseId) {
    return centerRepo.getCourseStudents(courseId);
  }
}
