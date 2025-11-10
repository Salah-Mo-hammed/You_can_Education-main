// import 'package:dartz/dartz.dart';
// import 'package:grad_project_ver_1/core/errors/failure.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/trainer/data/models/trainer_model.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/trainer/data/sources/remote/trainer_remote_data_source.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/repo/trianer_repo.dart';

import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/data/sources/remote/trainer_remote_data_source.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/repo/trianer_repo.dart';

class TrainerRepoImpl implements TrianerRepo {
  TrainerRemoteDataSource trainerRemoteDataSource;
  TrainerRepoImpl({required this.trainerRemoteDataSource});

  @override
  Future<Either<Failure, Map<String,dynamic>>> getTraienrCourses(
    String trainerId,
  ) {
    return trainerRemoteDataSource.getTraienrCourses(trainerId);
  }

  @override
  Future<Either<Failure, TrainerEntity>> getTraienrInfo(
    String trainerId,
  ) {
    return trainerRemoteDataSource.getTrainerInfo(trainerId);
  }
}

//   TrainerRepoImpl({required this.trainerRemoteDataSource});
//   // @override
//   // Future<Either<Failure, String>> createTrainer(
//   //   TrainerEntity newTrainer,
//   // ) {
//   //   TrainerModel trainerModel = TrainerModel(
//   //     uid: newTrainer.uid,
//   //     name: newTrainer.name,
//   //     email: newTrainer.email,
//   //     phone: newTrainer.phone,
//   //     imageUrl: newTrainer.imageUrl,
//   //     coursesIds: newTrainer.coursesIds,
//   //     password: newTrainer.password, centerId: newTrainer.centerId,
//   //   );
//   //   return trainerRemoteDataSource.createTrainer(trainerModel);
//   // }
// }
