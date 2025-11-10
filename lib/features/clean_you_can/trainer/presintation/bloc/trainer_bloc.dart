import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/usecases/get_trainer_info_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/usecases/get_triener_courses_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/bloc/trainer_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/bloc/trainer_state.dart';



class TrainerBloc extends Bloc<TrainerEvent, TrainerState> {
  GetTrienerCoursesUsecase getTrienerCoursesUsecase;
  GetTrainerInfoUsecase getTrainerInfoUsecase;
  TrainerBloc({required this.getTrienerCoursesUsecase,required this.getTrainerInfoUsecase})
    : super(TrainerInitialState()) {
    on<getTraienrCoursesEvent>(onGetTrainerCourses);
    on<getTraienrInfoEvent>(onGetTrainerInfo);

  }

  

  FutureOr<void> onGetTrainerCourses(getTraienrCoursesEvent event, Emitter<TrainerState> emit)async {
    emit(TrainerLoadingState());
    final result= await getTrienerCoursesUsecase.call(event.trainerId);
    result.fold((failure){
      emit(TrainerExceptionState(errorMessage: failure.message));
    }, (trainer_Courses){
      emit(TrainerGotHisCoursesState(trainerCourses: trainer_Courses));
    });
  }

  FutureOr<void> onGetTrainerInfo(getTraienrInfoEvent event, Emitter<TrainerState> emit)async {
     emit(TrainerLoadingState());
    final result= await getTrainerInfoUsecase.call(event.trainerId);
    result.fold((failure){
      emit(TrainerExceptionState(errorMessage: failure.message));
    }, (trainer){
      emit(TrainerGotHisInfoState(trainer: trainer));
    });
  }
}