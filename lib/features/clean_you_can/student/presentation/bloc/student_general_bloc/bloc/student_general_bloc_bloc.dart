import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/creat_student_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/get_student_info_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/student_log_out_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/update_student_data_usecase.dart';
part 'student_general_bloc_event.dart';
part 'student_general_bloc_state.dart';

class StudentGeneralBloc
    extends Bloc<StudentGeneralEvent, StudentGeneralState> {
  final CreatStudentUsecase creatStudentUsecase;
  final UpdateStudentDataUsecase updateStudentDataUsecase;
  final GetStudentInfoUsecase getStudentInfoUsecase;
  final LogoutStudentUsecase logoutStudentUsecase;
  StudentGeneralBloc({
    required this.logoutStudentUsecase,
    required this.creatStudentUsecase,
    required this.updateStudentDataUsecase,
    required this.getStudentInfoUsecase,
  }) : super(StudentGeneralInitial()) {
    on<CreateStudentEvent>(onCreateStudent);
    on<UpdateStudentInfoEvent>(onUpdateStudentInfo);
    on<GetStudentInfoEvent>(onGetStudentInfo);
    on<LogOutStudentEvent>(_onLogOutStudent);
  }

  FutureOr<void> onCreateStudent(
    CreateStudentEvent event,
    Emitter<StudentGeneralState> emit,
  ) async {
    emit(StudentGeneralLoadingState());
    final result = await creatStudentUsecase.call(
      event.createStudent,
    );
    result.fold(
      (failure) {
        emit(StudentGeneralExceptionState(message: failure.message));
      },
      (unit) {
        emit(StudentGeneralCreatedState());
      },
    );
  }

  FutureOr<void> onUpdateStudentInfo(
    UpdateStudentInfoEvent event,
    Emitter<StudentGeneralState> emit,
  ) async {
    emit(
      StudentGeneralLoadingState(),
    ); //StudentGeneralLoadingUpdateInfoState
    final result = await updateStudentDataUsecase.call(
      event.updateStudent,
    );
    result.fold(
      (failure) {
        emit(StudentGeneralExceptionState(message: failure.message));
      },
      (unit) {
        emit((StudentGenralUpdatedState()));
      },
    );
  }

  FutureOr<void> onGetStudentInfo(
    GetStudentInfoEvent event,
    Emitter<StudentGeneralState> emit,
  ) async {
    emit(StudentGeneralLoadingState());
    final result = await getStudentInfoUsecase.call(event.studentId);
    result.fold(
      (failure) {
        emit(StudentGeneralExceptionState(message: failure.message));
      },
      (student) {
        emit(StudentGeneralGotInfoState(currentStudent: student));
      },
    );
  }

  FutureOr<void> _onLogOutStudent(
    LogOutStudentEvent event,
    Emitter<StudentGeneralState> emit,
  ) async {
    emit(StudentGeneralLoadingState());
    final result = await logoutStudentUsecase.call();
    result.fold(
      (failure) {
        emit(StudentGeneralExceptionState(message: failure.message));
      },
      (_) {
        emit(StudentGeneralInitial());
        print(
          "**************************************************************** uid for auth now is ${state}",
        );
      },
    );
  }
}
