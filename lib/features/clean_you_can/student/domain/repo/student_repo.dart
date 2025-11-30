import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';

abstract class StudentRepo {
  Future<Either<Failure, void>> createStudent(
    StudentEntity newStudent,
  );
  
   Future<Either<Failure, Unit>> logOutStudent();
   Future<Either<Failure, void>> updateStudentInfo(StudentEntity updateStudent);
   Future<Either<Failure, StudentEntity>> getStudentInfo(String studentId);

  Future<Either<Failure, Map<String,dynamic>>>
  getAVaialableAndMineCourses(String studentId);
  Future<Either<Failure, Unit>> enrollInCourse(
    String centerId,
    String studentId,
    String courseId,
    String courseName,


  );
}
