import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';

abstract class CourseRepo {
  Future<Either<Failure, CourseEntity>> getCourseDetails(int courseId);
}
