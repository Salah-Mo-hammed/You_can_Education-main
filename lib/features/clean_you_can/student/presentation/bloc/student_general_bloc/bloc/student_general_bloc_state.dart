part of 'student_general_bloc_bloc.dart';

sealed class StudentGeneralState {
  const StudentGeneralState();
}

final class StudentGeneralInitial extends StudentGeneralState {}

class StudentGeneralCreatedState extends StudentGeneralState {}

class StudentGeneralGotInfoState extends StudentGeneralState {
  StudentEntity currentStudent;
  StudentGeneralGotInfoState({required this.currentStudent});
}

class StudentGeneralLoadingState extends StudentGeneralState {}

class StudentGenralUpdatedState extends StudentGeneralState {}

// class StudentLoadingUpdateInfoState extends StudentGeneralState {}
class StudentGeneralExceptionState extends StudentGeneralState {
  // ignore: prefer_typing_uninitialized_variables
  final message;
  StudentGeneralExceptionState({required this.message});
}