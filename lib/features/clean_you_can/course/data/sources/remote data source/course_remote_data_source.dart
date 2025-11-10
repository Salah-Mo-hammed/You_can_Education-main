import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/data/models/course_model.dart';

class CourseDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Either<Failure, CourseModel>> getCourseDetails(int courseId) async {
  
  try {
      final docSnapShot =
        await _firestore.collection('Courses').doc(courseId.toString()).get();
    if (docSnapShot.exists) {
      return Right(CourseModel.fromJson(docSnapShot.data()!));
    } else {
      return Left(DatabaseFailure("course not found"));
    }
  
  } catch (e) {
      return Left(DatabaseFailure("failed to fetch course details"));
    
  }
  }
}
