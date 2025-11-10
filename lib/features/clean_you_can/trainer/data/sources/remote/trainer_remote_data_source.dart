// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:grad_project_ver_1/core/errors/failure.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/trainer/data/models/trainer_model.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/data/models/course_model.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/data/models/trainer_model.dart';

class TrainerRemoteDataSource {
  final _firestore = FirebaseFirestore.instance;

  Future<Either<Failure, TrainerModel>> getTrainerInfo(
    String trainerId,
  ) async {
    try {
      final trainerDoc =
          await _firestore
              .collection("Trainers")
              .doc(trainerId)
              .get();
      if (!trainerDoc.exists) {
        return Left(ServerFailure("no trainers with this id"));
      }
      final trainerData = trainerDoc.data() as Map<String, dynamic>;
      final trainerInfo = TrainerModel.fromJson(trainerData);
      return Right(trainerInfo);
    } catch (e) {
      return Left(
        ServerFailure(
          "couldnt get the info of trainer : ${e.toString()}",
        ),
      );
    }
  }

  Future<Either<Failure, Map<String,dynamic>>> getTraienrCourses(
    String trainerId,
  ) async {
    try {
          // 1. Get Trainer Info
    final trainerResult = await getTrainerInfo(trainerId);
    if (trainerResult.isLeft()) {
      return Left(
        ServerFailure("Could not fetch trainer info"),
      );
    }
    final trainer = trainerResult.getOrElse(() => throw Exception("Trainer not found"));

      final querySnapshot =
          await _firestore
              .collection('Courses')
              .where('trainerId', isEqualTo: trainerId)
              .get();

      if (querySnapshot.docs.isEmpty) {
        return Right(
          {'trainer':trainer,'courses':[]},
        ); // لو مفيش كورسات، رجّع ليست فاضية بدل ما ترجع خطأ
      }

      final courses =
          querySnapshot.docs
              .map((doc) {
                final data = doc.data();

                if (data.containsKey('trainerId')) {
                  return CourseModel.fromJson(data);
                } else {
                  return null; // استبعاد أي بيانات ناقصة
                }
              })
              .whereType<
                CourseModel
              >() // إزالة القيم null وتحويل الليستة تلقائيًا إلى List<CourseModel>
              .toList();

      return Right({'trainer':trainer,'courses':courses});
    } catch (e) {
      return Left(
        ServerFailure(
          "Faild to get trainer courses: ${e.toString()}",
        ),
      );
    }
  }
}
//   final  _firestore=FirebaseFirestore.instance;

//   Future<Either<Failure, List<TrainerEntity>>> fetchCenterTrainers(
//     String centerId,
//   ) async {
//     try {
//       final querySnapshot =
//           await _firestore
//               .collection('Trainers')
//               .where('centerId', isEqualTo: centerId)
//               .get();

//       if (querySnapshot.docs.isEmpty) {
//         return Right(
//           [],
//         ); // لو مفيش مدربين، رجّع ليست فاضية بدل ما ترجع خطأ
//       }

//       final trainers =
//           querySnapshot.docs
//               .map((doc) {
//                 final data = doc.data();

//                 if (data.containsKey('centerId')) {
//                   return TrainerModel.fromJson(data);
//                 } else {
//                   return null; // استبعاد أي بيانات ناقصة
//                 }
//               })
//               .whereType<
//                 TrainerModel
//               >() // إزالة القيم null وتحويل الليستة تلقائيًا إلى List<TrainerModel>
//               .toList();

//       return Right(trainers);
//     } catch (e) {
//       return Left(
//         ServerFailure("Faild to get trainers: ${e.toString()}"),
//       );
//     }
//   }
 


// }