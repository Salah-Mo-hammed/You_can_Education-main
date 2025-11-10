import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/data/sources/remote%20data%20source/course_remote_data_source.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/repo/course_repo.dart';

class CourseRepoImpl implements CourseRepo {
  CourseDataSource courseDataSource;
  CourseRepoImpl({required this.courseDataSource});
  @override
  Future<Either<Failure, CourseEntity>> getCourseDetails(int courseId) {
    return courseDataSource.getCourseDetails(courseId);
  }
}
