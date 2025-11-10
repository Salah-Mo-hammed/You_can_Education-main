
import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/auth/domain/repo/auth_repo.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/repo/student_repo.dart';

class LogoutStudentUsecase {
  StudentRepo studentRepo;
  LogoutStudentUsecase({required this.studentRepo});
  Future<Either<Failure,void>> call() {
    return studentRepo.logOutStudent();
  }
}


 