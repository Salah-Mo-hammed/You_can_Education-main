import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/data/models/student_model.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/data/sources/remote/student_data_source.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/repo/student_repo.dart';

class StudentRepoImpl implements StudentRepo {
  WithFirebase studentDataSource;
  StudentRepoImpl({required this.studentDataSource});
  @override
  Future<Either<Failure, void>> createStudent(
    StudentEntity newStudent,
  ) {
    StudentModel studentModel = StudentModel(
      studentId: newStudent.studentId,
      name: newStudent.name,
      email: newStudent.email,
      phoneNumber: newStudent.phoneNumber,
      address: newStudent.address,
      photoUrl: newStudent.photoUrl,
      courses: {},
    );
    return studentDataSource.createStudent(studentModel);
  }

  @override
  Future<Either<Failure, Unit>> logOutStudent() {
    return studentDataSource.logOutStudent();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
  getAVaialableAndMineCourses(String syudentId) {
    return studentDataSource.getAVaialableCourses(syudentId);
  }

  @override
  Future<Either<Failure, Unit>> enrollInCourse(
    String centerId,
    String studentId,
    String courseId,
    String courseName /*String proofImageUrl */,
  ) {
    return studentDataSource.enrollInCourse(
      centerId,
      studentId,
      courseId,
      courseName /*proofImageUrl */,
    );
  }

  @override
  Future<Either<Failure, void>> updateStudentInfo(
    StudentEntity newStudent,
  ) {
    StudentModel studentModel = StudentModel(
      studentId: newStudent.studentId,
      name: newStudent.name,
      email: newStudent.email,
      phoneNumber: newStudent.phoneNumber,
      address: newStudent.address,
      photoUrl: newStudent.photoUrl,
      courses: {},
    );
    return studentDataSource.updateStudentInfo(studentModel);
  }

  @override
  Future<Either<Failure, StudentEntity>> getStudentInfo(
    String studentId,
  ) {
    return studentDataSource.getstudentInfo(studentId);
  }
}
