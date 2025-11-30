import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/repo/student_repo.dart';

class GetAvailableAndMineCoursesUsecase {
  final StudentRepo studentRepo;
  GetAvailableAndMineCoursesUsecase({required this.studentRepo});
  Future<Either<Failure, Map<String,dynamic>>> call(String studentId) {
    return studentRepo.getAVaialableAndMineCourses(studentId);
  }
}
