import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/repo/student_repo.dart';

class UpdateStudentDataUsecase {
  StudentRepo studentRepo;
  UpdateStudentDataUsecase({required this.studentRepo});
  Future<Either<Failure,void>> call(StudentEntity updatedStudent) {
    return studentRepo.updateStudentInfo(updatedStudent);
  }
}
