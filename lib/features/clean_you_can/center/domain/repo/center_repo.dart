import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/entities/center_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

abstract class CenterRepo {
  //! for center_course_bloc
  Future<Either<Failure, CourseEntity>> addCourse(
    CourseEntity courseEntity,
  );
  Future<Either<Failure, String>> updateCourse(
    CourseEntity courseEntity,
  );
  Future<Either<Failure, String>> deleteCourse(String courseId);
  Future<Either<Failure, List<CourseEntity>>> getCenterCourses(
    String centerId,
  ); // each course entity have parameter called center (center who own the course)
  Future<Either<Failure, String>> addCourseSession(
    String courseId,
    String sessionTitle,
    String sessionUrl,
  );
  Future<Either<Failure, List<StudentEntity>>> getCourseStudents(
    int courseId,
  );

  //! for center_trainers_bloc
  Future<Either<Failure, String>> createTrainer(
    TrainerEntity newTrainer,
    String password,
  );
  Future<Either<Failure, List<TrainerEntity>>> fetchCenterTrainers(
    String centerId,
  );
  Future<Either<Failure, List<Map<String, dynamic>>>>
  getCenterRequests(String centerId);
  Future<Either<Failure, void>> approveJoinRequest(
    Map<String, dynamic> requestMap,
  );

  //! for center_general_bloc
  Future<Either<Failure, void>> createCenter(CenterEntity newCenter);
  Future<Either<Failure, CenterEntity>> getCenterInfo(
    String centerId,
  );
  Future<Either<Failure, void>> updateCenterInfo(
    CenterEntity updatedCourse,
  );
  Future<Either<Failure, Unit>> logOutCenter();
}
