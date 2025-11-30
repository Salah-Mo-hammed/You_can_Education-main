import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/data/models/center_model.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/data/sources/remote/center_data_source.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/entities/center_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/repo/center_repo.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/data/models/course_model.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/data/models/trainer_model.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

class CenterRepoImpl implements CenterRepo {
  CenterDataSource centerDataSource;
  CenterRepoImpl({
    required this.centerDataSource,
    //    required AuthDataSource authDataSource,
  });

  @override
  Future<Either<Failure, void>> createCenter(CenterEntity newCenter) {
    CenterModel newCenter0 = CenterModel(
      centerId: newCenter.centerId,
      name: newCenter.name,
      email: newCenter.email,
      phoneNumber: newCenter.phoneNumber,
      address: newCenter.address,
      description: newCenter.description,
    );
    return centerDataSource.createCenter(newCenter0);
  }

  @override
  Future<Either<Failure, CourseEntity>> addCourse(
    CourseEntity courseEntity,
  ) {
    CourseModel courseModel = CourseModel(
      courseId: courseEntity.courseId,
      title: courseEntity.title,
      description: courseEntity.description,
      centerId: courseEntity.centerId,
      price: courseEntity.price,
      startDate: courseEntity.startDate,
      endDate: courseEntity.endDate,
      topics: courseEntity.topics,
      maxStudents: courseEntity.maxStudents,
      trainerId: courseEntity.trainerId,
      imageUrl: courseEntity.imageUrl,
    );
    return centerDataSource.addCourse(courseModel);
  }

  @override
  Future<Either<Failure, String>> deleteCourse(String courseId) {
    return centerDataSource.deleteCourse(courseId);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getCenterCourses(
    String centerId,
  ) {
    return centerDataSource.getCenterCourses(centerId);
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getCourseStudents(
    int courseId,
  ) {
    // TODO: implement getCourseStudents
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updateCourse(
    CourseEntity courseEntity,
  ) async {
    CourseModel courseModel = CourseModel(
      courseId: courseEntity.courseId,
      title: courseEntity.title,
      description: courseEntity.description,
      centerId: courseEntity.centerId,
      price: courseEntity.price,
      startDate: courseEntity.startDate,
      endDate: courseEntity.endDate,
      topics: courseEntity.topics,
      maxStudents: courseEntity.maxStudents,
      trainerId: courseEntity.trainerId,
    );
    return centerDataSource.updateCourse(courseModel);
  }

  @override
  Future<Either<Failure, List<TrainerEntity>>> fetchCenterTrainers(
    String centerId,
  ) {
    return centerDataSource.fetchCenterTrainers(centerId);
  }

  @override
  Future<Either<Failure, String>> createTrainer(
    TrainerEntity newTrainer,
    String password,
  ) {
    TrainerModel trainerModel = TrainerModel(
      uid: newTrainer.uid,
      name: newTrainer.name,
      email: newTrainer.email,
      phone: newTrainer.phone,
      imageUrl: newTrainer.imageUrl,
      coursesId: newTrainer.coursesId,
      centerId: newTrainer.centerId,
    );
    return centerDataSource.createTrainer(trainerModel, password);
  }

  @override
  Future<Either<Failure, CenterEntity>> getCenterInfo(
    String centerId,
  ) {
    return centerDataSource.getCenterInfo(centerId);
  }

  @override
  Future<Either<Failure, void>> updateCenterInfo(
    CenterEntity updatedCourse,
  ) {
    CenterModel centerModel = CenterModel(
      centerId: updatedCourse.centerId,
      name: updatedCourse.name,
      email: updatedCourse.email,
      phoneNumber: updatedCourse.phoneNumber,
      address: updatedCourse.address,
      description: updatedCourse.description,
      imageUrl: updatedCourse.imageUrl,
    );
    return centerDataSource.updateCenterInfo(centerModel);
  }

  @override
  Future<Either<Failure, String>> addCourseSession(
    String courseId,
    String sessionTitle,
    String sessionUrl,
  ) {
    return centerDataSource.addCourseSession(
      courseId,
      sessionTitle,
      sessionUrl,
    );
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>>
  getCenterRequests(String centerId) {
    return centerDataSource.getCenterRequests(centerId);
  }

  @override
  Future<Either<Failure, void>> approveJoinRequest(
    Map<String, dynamic> requestMap,
  ) {
    return centerDataSource.approveJoinRequest(requestMap);
  }
  
  @override
  Future<Either<Failure, Unit>> logOutCenter() {
    return centerDataSource.logOutCenter();
    }
}
