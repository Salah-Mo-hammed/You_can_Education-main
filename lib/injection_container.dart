import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:grad_project_ver_1/features/auth/data/source/remote/auth_data_source.dart';
import 'package:grad_project_ver_1/features/auth/data/repo_impl/repo_impl.dart';
import 'package:grad_project_ver_1/features/auth/domain/repo/auth_repo.dart';
import 'package:grad_project_ver_1/features/auth/domain/usecases/forget_pass_usecase.dart';
import 'package:grad_project_ver_1/features/auth/domain/usecases/get_auth_usecase.dart.dart';
import 'package:grad_project_ver_1/features/auth/domain/usecases/login_usecase.dart';
import 'package:grad_project_ver_1/features/auth/domain/usecases/logout_usecase.dart';
import 'package:grad_project_ver_1/features/auth/domain/usecases/register_usecase.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:grad_project_ver_1/features/chat/data/repo_impl/chat_repo_impl.dart';
import 'package:grad_project_ver_1/features/chat/data/source/chat_remote_data_souce.dart';
import 'package:grad_project_ver_1/features/chat/domain/repo/chat_repo.dart';
import 'package:grad_project_ver_1/features/chat/domain/usecases/get_or_create_chat_room_usecase.dart';
import 'package:grad_project_ver_1/features/chat/domain/usecases/get_trainer_chat_rooms_usecase.dart';
import 'package:grad_project_ver_1/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:grad_project_ver_1/features/chat/domain/usecases/stream_messages_usecases.dart';
import 'package:grad_project_ver_1/features/chat/presintation/bloc/chat_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/data/repo_impl/center_repo_impl.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/data/sources/remote/center_data_source.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/repo/center_repo.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/add_course_session_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/approve_join_request_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/center_log_out_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/create_centerusecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/create_course_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/delete_course_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/fetch_center_trainers_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/get_center_courses_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/get_center_info_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/get_center_requests_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/get_course_students.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/update_center_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/update_course_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_courses_bloc/center_courses_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_general_bloc/center_general_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_requests_bloc/center_requests_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/data/repo_impl/stu_repo_impl.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/data/sources/remote/student_data_source.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/repo/student_repo.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/creat_student_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/enroll_in_course_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/get_available_courses_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/get_student_info_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/student_log_out_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/usecases/update_student_data_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/usecases/create_trainer_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_general_bloc/bloc/student_general_bloc_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/data/repo_impl/trainer_repo_impl.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/data/sources/remote/trainer_remote_data_source.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/repo/trianer_repo.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/usecases/get_trainer_info_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/usecases/get_triener_courses_usecase.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/bloc/trainer_bloc.dart';

GetIt sl = GetIt.instance;
Future<void> initialaizedDependencies() async {
  //! Note: you must do it with  this arrangement : http request or Dio => data-dataSource => repo (<repo from domain>(repoimple)) =>

  //! domain-usecases => blocs
  sl.registerSingleton<Dio>(Dio());
  //! data-dataSource
  sl.registerSingleton<AuthDataSource>(AuthDataSource());
  sl.registerSingleton<WithFirebase>(WithFirebase());
  sl.registerSingleton<CenterDataSource>(CenterDataSource());
  sl.registerSingleton<TrainerRemoteDataSource>(
    TrainerRemoteDataSource(),
  );
  sl.registerSingleton<ChatRemoteDataSource>(ChatRemoteDataSource());

  //! domain-repo but inside it repo impl
  sl.registerSingleton<AuthRepo>(
    AuthRepoImpl(authDataSource: sl<AuthDataSource>()),
  );
  sl.registerSingleton<StudentRepo>(
    StudentRepoImpl(studentDataSource: sl<WithFirebase>()),
  );
  sl.registerSingleton<CenterRepo>(
    CenterRepoImpl(
      //   authDataSource: sl<AuthDataSource>(),
      centerDataSource: sl<CenterDataSource>(),
    ),
  );
  sl.registerSingleton<TrianerRepo>(
    TrainerRepoImpl(
      trainerRemoteDataSource: sl<TrainerRemoteDataSource>(),
    ),
  );
  sl.registerSingleton<ChatRepo>(
    ChatRepoImpl(chatRemoteDataSource: sl<ChatRemoteDataSource>()),
  );
  //! domain-usecases

  sl.registerSingleton<LogInUsecase>(
    LogInUsecase(repo: sl<AuthRepo>()),
  );
  sl.registerSingleton<LogOutUsecase>(
    LogOutUsecase(repo: sl<AuthRepo>()),
  );
  sl.registerSingleton<RegisterUsecase>(
    RegisterUsecase(repo: sl<AuthRepo>()),
  );

  sl.registerSingleton<GetAuthStatusUseCase>(
    GetAuthStatusUseCase(repo: sl<AuthRepo>()),
  );
  sl.registerSingleton<ForgetPassUsecase>(
    ForgetPassUsecase(repo: sl<AuthRepo>()),
  );

  sl.registerSingleton<CreatStudentUsecase>(
    CreatStudentUsecase(studentRepo: sl<StudentRepo>()),
  );
  sl.registerSingleton<UpdateStudentDataUsecase>(
    UpdateStudentDataUsecase(studentRepo: sl<StudentRepo>()),
  );
  sl.registerSingleton<CreateCenterusecase>(
    CreateCenterusecase(centerRepo: sl<CenterRepo>()),
  );

  sl.registerSingleton<AddCourseUsecase>(
    AddCourseUsecase(centerRepo: sl<CenterRepo>()),
  );
  sl.registerSingleton<DeleteCourseUsecase>(
    DeleteCourseUsecase(centerRepo: sl<CenterRepo>()),
  );
  sl.registerSingleton<UpdateCourseUsecase>(
    UpdateCourseUsecase(centerRepo: sl<CenterRepo>()),
  );
  sl.registerSingleton<GetCenterCoursesUsecase>(
    GetCenterCoursesUsecase(centerRepo: sl<CenterRepo>()),
  );
  sl.registerSingleton<GetCourseStudents>(
    GetCourseStudents(centerRepo: sl<CenterRepo>()),
  );
  sl.registerSingleton<LogOutCenterUseCases>(
    LogOutCenterUseCases(centerRepo: sl<CenterRepo>()),
  );
  sl.registerSingleton<GetAvailableAndMineCoursesUsecase>(
    GetAvailableAndMineCoursesUsecase(studentRepo: sl<StudentRepo>()),
  );
  sl.registerSingleton<EnrollInCourseUsecase>(
    EnrollInCourseUsecase(studentRepo: sl<StudentRepo>()),
  );
  sl.registerSingleton<GetStudentInfoUsecase>(
    GetStudentInfoUsecase(studentRepo: sl<StudentRepo>()),
  );

  sl.registerSingleton<CreateTrainerUsecase>(
    CreateTrainerUsecase(centerRepo: sl<CenterRepo>()),
  );
  sl.registerSingleton<FetchCenterTrainersUsecase>(
    FetchCenterTrainersUsecase(centerRepo: sl<CenterRepo>()),
  );
  sl.registerSingleton<GetCenterInfoUsecase>(
    GetCenterInfoUsecase(centerRepo: sl<CenterRepo>()),
  );

  sl.registerSingleton<UpdatedCenterInfoUsecase>(
    UpdatedCenterInfoUsecase(centerRepo: sl<CenterRepo>()),
  );
  sl.registerSingleton<AddCourseSessionUsecase>(
    AddCourseSessionUsecase(centerRepo: sl<CenterRepo>()),
  );
  sl.registerSingleton<GetCenterRequestsUsecase>(
    GetCenterRequestsUsecase(centerRepo: sl<CenterRepo>()),
  );
  sl.registerSingleton<ApproveJoinRequestUsecase>(
    ApproveJoinRequestUsecase(centerRepo: sl<CenterRepo>()),
  );

  sl.registerSingleton<GetTrienerCoursesUsecase>(
    GetTrienerCoursesUsecase(trianerRepo: sl<TrianerRepo>()),
  );
  sl.registerSingleton<GetTrainerInfoUsecase>(
    GetTrainerInfoUsecase(trianerRepo: sl<TrianerRepo>()),
  );
  sl.registerSingleton<GetOrCreateChatRoomUsecase>(
    GetOrCreateChatRoomUsecase(chatRepo: sl<ChatRepo>()),
  );
  sl.registerSingleton<SendMessageUsecase>(
    SendMessageUsecase(chatRepo: sl<ChatRepo>()),
  );
  sl.registerSingleton<StreamMessagesUsecases>(
    StreamMessagesUsecases(chatRepo: sl<ChatRepo>()),
  );
  sl.registerSingleton<GetTrainerChatRoomsUsecase>(
    GetTrainerChatRoomsUsecase(chatRepo: sl<ChatRepo>()),
  );

  sl.registerSingleton<LogoutStudentUsecase>(
    LogoutStudentUsecase(studentRepo: sl<StudentRepo>()),
  );
  //! blocs

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      logInUsecase: sl<LogInUsecase>(),
      logOutUsecase: sl<LogOutUsecase>(),
      registerUsecase: sl<RegisterUsecase>(),
      getAuthStatusUseCase: sl<GetAuthStatusUseCase>(),
      resetPassUseCase: sl<ForgetPassUsecase>(),
    ),
  );
  sl.registerFactory(
    () => StudentBloc(
      getAvailableCoursesUsecase:
          sl<GetAvailableAndMineCoursesUsecase>(),
      enrollInCourseUsecase: sl<EnrollInCourseUsecase>(),
      logoutStudentUsecase: sl<LogoutStudentUsecase>(),
    ),
  );
  sl.registerFactory(
    () => StudentGeneralBloc(
      creatStudentUsecase: sl<CreatStudentUsecase>(),
      updateStudentDataUsecase: sl<UpdateStudentDataUsecase>(),
      getStudentInfoUsecase: sl<GetStudentInfoUsecase>(),
      logoutStudentUsecase: sl<LogoutStudentUsecase>(),
    ),
  );
  sl.registerFactory(
    () => CenterTrainerBloc(
      fetchCenterTrainersUsecase: sl<FetchCenterTrainersUsecase>(),
      createTrainerUsecase: sl<CreateTrainerUsecase>(), logOutCenterUseCases: sl<LogOutCenterUseCases>(),
    ),
  );
  sl.registerFactory(
    () => CenterRequestsBloc(logOutCenterUseCases: sl<LogOutCenterUseCases>(),
      getCenterRequestsUsecase: sl<GetCenterRequestsUsecase>(),
      approveJoinRequestUsecase: sl<ApproveJoinRequestUsecase>(),
    ),
  );

  sl.registerFactory(
    () => CenterGeneralBloc(logOutCenterUseCases: sl<LogOutCenterUseCases>(),
      createCenterusecase: sl<CreateCenterusecase>(),
      getCenterInfoUsecase: sl<GetCenterInfoUsecase>(),
      updatedCenterInfoUsecase: sl<UpdatedCenterInfoUsecase>(),
    ),
  );
  sl.registerFactory(
    () => CenterCoursesBloc(logOutCenterUseCases: sl<LogOutCenterUseCases>(),
      addCourseUsecase: sl<AddCourseUsecase>(),
      getCenterCoursesUsecase: sl<GetCenterCoursesUsecase>(),
      updateCourseUsecase: sl<UpdateCourseUsecase>(),
      deleteCourseUsecase: sl<DeleteCourseUsecase>(),
      addCourseSessionUsecase: sl<AddCourseSessionUsecase>(),
    ),
  );

  sl.registerFactory(
    () => TrainerBloc(
      getTrienerCoursesUsecase: sl<GetTrienerCoursesUsecase>(),
      getTrainerInfoUsecase: sl<GetTrainerInfoUsecase>(),
    ),
  );
  sl.registerFactory(
    () => ChatBloc(
      getOrCreateChatRoom: sl<GetOrCreateChatRoomUsecase>(),
      sendMessage: sl<SendMessageUsecase>(),
      streamMessages: sl<StreamMessagesUsecases>(),
      getTrainerChatRoomsUsecase: sl<GetTrainerChatRoomsUsecase>(),
    ),
  );
}
