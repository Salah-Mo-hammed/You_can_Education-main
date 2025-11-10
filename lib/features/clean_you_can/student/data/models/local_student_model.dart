// import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/studentEntity.dart';
// import 'package:isar/isar.dart';
// part 'local_student_model.g.dart';

// @Collection()
// class StudentCollection {
// Id id=Isar.autFoIncrement;
//   late String studentId;
//   late String name;
//   late String email;
//   late String phoneNumber;
//   late String address;
//   String? photoUrl;
//   late List<int> registeredCourses;

//   StudentCollection();

//   /// Construct from  domain entity
//   StudentCollection.fromEntity(StudentEntity e) {
//     studentId = e.studentId;
//     name          = e.name;
//     email         = e.email;
//     phoneNumber   = e.phoneNumber;
//     address       = e.address;
//     photoUrl      = e.photoUrl;
//     registeredCourses = e.registerdCourses;
//   }

//   /// Convert back to  domain entity
//   StudentEntity toEntity() {
//     return StudentEntity(
//       studentId:       studentId,
//       name:            name,
//       email:           email,
//       phoneNumber:     phoneNumber,
//       address:         address,
//       photoUrl:        photoUrl,
//       registerdCourses: registeredCourses,
//     );
//   }
// }
