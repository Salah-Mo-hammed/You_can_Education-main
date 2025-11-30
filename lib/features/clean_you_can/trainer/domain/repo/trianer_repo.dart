import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

abstract class TrianerRepo {

Future<Either<Failure, Map<String,dynamic>>> getTraienrCourses(String trainerId);
Future<Either<Failure,TrainerEntity>> getTraienrInfo(String trainerId);

}