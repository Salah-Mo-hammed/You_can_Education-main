import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/center_log_out_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/create_trainer_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/fetch_center_trainers_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_state.dart';

class CenterTrainerBloc
    extends Bloc<CenterTrainerEvent, CenterTrainerState> {
  FetchCenterTrainersUsecase fetchCenterTrainersUsecase;
  CreateTrainerUsecase createTrainerUsecase;
  LogOutCenterUseCases logOutCenterUseCases;
  CenterTrainerBloc({
    required this.logOutCenterUseCases,
    required this.fetchCenterTrainersUsecase,
    required this.createTrainerUsecase,
  }) : super(CenterTrainerInitialState()) {
    on<FetchCenterTrainers>(onFetchCenterTrainers);
    on<CreateTrainerEvent>(onCreateCenter);
    on<CenterLogOutTrainerPartEvent>(_onLogOutCenterTrainer);
  }
  FutureOr<void> onCreateCenter(
    CreateTrainerEvent event,
    Emitter<CenterTrainerState> emit,
  ) async {
    emit(CenterTrainerLoadingState());
    final result = await createTrainerUsecase.call(
      event.newTrainer,
      event.password,
    );
    result.fold(
      (failure) {
        emit(CenterTrainerExceptionState(message: failure.message));
      },
      (generatedUid) {
        emit(CenterTrainerCreatedState(newTrainerUid: generatedUid));
      },
    );
  }

  FutureOr<void> onFetchCenterTrainers(
    FetchCenterTrainers event,
    Emitter<CenterTrainerState> emit,
  ) async {
    emit(CenterTrainerLoadingState());
    final result = await fetchCenterTrainersUsecase.call(
      event.centerId,
    );
    result.fold(
      (failure) {
        emit(CenterTrainerExceptionState(message: failure.message));
      },
      (trainers) {
        emit(CenterGotTrainersState(trainers: trainers));
      },
    );
  }

  FutureOr<void> _onLogOutCenterTrainer(
    CenterLogOutTrainerPartEvent event,
    Emitter<CenterTrainerState> emit,
  ) async {
    emit(CenterTrainerLoadingState());
    final result = await logOutCenterUseCases.call();
    result.fold(
      (failure) {
        emit(CenterTrainerExceptionState(message: failure.message));
      },
      (_) {
        emit(CenterTrainerInitialState());
      },
    );
  }
}
/*
old one (just one bloc for center)
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/create_centerusecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/create_course_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/delete_course_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/fetch_center_trainers_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/get_center_courses_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/update_course_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_state.dart';

class CenterBloc extends Bloc<CenterEvent, CenterState> {
  CreateCenterusecase createCenterusecase;
  AddCourseUsecase addCourseUsecase;
  UpdateCourseUsecase updateCourseUsecase;
  GetCenterCoursesUsecase getCenterCoursesUsecase;
  DeleteCourseUsecase deleteCourseUsecase;
  FetchCenterTrainersUsecase fetchCenterTrainersUsecase;
  CenterBloc({required this.fetchCenterTrainersUsecase,
    required this.deleteCourseUsecase,
    required this.updateCourseUsecase,
    required this.createCenterusecase,
    required this.addCourseUsecase,
    required this.getCenterCoursesUsecase,
  }) : super(const CenterInitialState()) {
    on<CreateCenterEvent>(onCreateCenter);
    on<AddCourseEvent>(onAddCourse);
    on<GetCenterCoursesEvent>(onGetCenterCourses);
    on<UpdateCourseEvent>(onUpdateCourse);
    on<DeleteCourseEvent>(onDeleteCourse);
    on<FetchCenterTrainers>(onFetchCenterTrainers);
  }

  FutureOr<void> onCreateCenter(
    CreateCenterEvent event,
    Emitter<CenterState> emit,
  ) async {
    emit(CenterLoadingState());
    final result = await createCenterusecase.call(event.createCenter);
    result.fold(
      (failure) {
        emit(CenterExceptionState(message: failure.message));
      },
      (unit) {
        emit(CenterCreatedState());
      },
    );
  }

  FutureOr<void> onAddCourse(
    AddCourseEvent event,
    Emitter<CenterState> emit,
  ) async {
    emit(CenterLoadingState());
    final result = await addCourseUsecase.call(event.addCourseEntity);
    result.fold(
      (failure) {
        emit(CenterExceptionState(message: failure.message));
      },
      (course) {
        emit(CenterAddedCourseState(courseEntity: course));
      },
    );
  }

  FutureOr<void> onGetCenterCourses(
    GetCenterCoursesEvent event,
    Emitter<CenterState> emit,
  ) async {
    emit(CenterLoadingState());

    final result = await getCenterCoursesUsecase.call(event.centerId);
    result.fold(
      (failure) {
        emit(CenterExceptionState(message: failure.message));
      },
      (courses) {
        emit(CenterGotCoursesState(courses: courses));
        
      },
    );
  }

  FutureOr<void> onUpdateCourse(
    UpdateCourseEvent event,
    Emitter<CenterState> emit,
  ) async {
    emit(CenterLoadingState());
    final result = await updateCourseUsecase.call(event.updateCourseEntity);
    result.fold(
      (failure) {
        emit(CenterExceptionState(message: failure.message));
      },
      (successMessage) {
        emit(CenterUpdatedCourseState());
      },
    );
  }

  FutureOr<void> onDeleteCourse(
    DeleteCourseEvent event,
    Emitter<CenterState> emit,
  ) async {
    emit(CenterLoadingState());
    final result = await deleteCourseUsecase.call(event.courseId);
    result.fold(
      (failure) {
        emit(CenterExceptionState(message: failure.message));
      },
      (success) {
        emit(CenterInitialState());
      },
    );
  }

  FutureOr<void> onFetchCenterTrainers(FetchCenterTrainers event, Emitter<CenterState> emit) async{
    emit(CenterLoadingState());
final result= await fetchCenterTrainersUsecase.call(event.centerId);
result.fold((failure){
  emit(CenterExceptionState(message: failure.message));
},(trainers){
  emit(CenterGotTrainersState(trainers: trainers));
});
  }
}

 */