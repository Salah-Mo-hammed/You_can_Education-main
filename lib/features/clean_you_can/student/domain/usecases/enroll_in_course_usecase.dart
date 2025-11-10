import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/repo/student_repo.dart';

class EnrollInCourseUsecase {
  StudentRepo studentRepo;
EnrollInCourseUsecase({required this.studentRepo});
Future<Either<Failure,Unit>> call(String centerId ,String studentUid,String courseId,String courseName,/*String proofImageUrl */ ){
  return studentRepo.enrollInCourse(centerId,studentUid, courseId ,courseName,/*proofImageUrl */);
}
}