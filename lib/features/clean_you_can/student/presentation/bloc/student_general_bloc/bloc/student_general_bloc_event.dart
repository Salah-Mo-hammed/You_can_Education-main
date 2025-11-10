part of 'student_general_bloc_bloc.dart';

sealed class StudentGeneralEvent {
  const StudentGeneralEvent();
}

class CreateStudentEvent extends StudentGeneralEvent {
  StudentEntity createStudent;
  CreateStudentEvent({required this.createStudent});
}
class LogOutStudentEvent extends StudentGeneralEvent {

  LogOutStudentEvent();
}

class UpdateStudentInfoEvent extends StudentGeneralEvent {
  StudentEntity updateStudent;
  UpdateStudentInfoEvent({required this.updateStudent});
}

class GetStudentInfoEvent extends StudentGeneralEvent {
  String studentId;
  GetStudentInfoEvent({required this.studentId});
}
