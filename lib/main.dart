import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/core/splash_page.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:grad_project_ver_1/features/chat/presintation/bloc/chat_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_courses_bloc/center_courses_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_general_bloc/center_general_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_requests_bloc/center_requests_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_general_bloc/bloc/student_general_bloc_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/bloc/trainer_bloc.dart';
import 'package:grad_project_ver_1/firebase_options.dart';
import 'package:grad_project_ver_1/injection_container.dart';
import 'package:grad_project_ver_1/restart_widget.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  debugPrintRebuildDirtyWidgets = false;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );
  // final token = await FirebaseAppCheck.instance.getToken(true);
  // print(" Debug App Check Token: $token");

  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );

  await initialaizedDependencies();
  runApp(RestartWidget(child: const MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp();
  print("Background notification: ${message.notification?.title}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<StudentBloc>(create: (_) => sl<StudentBloc>()),
        BlocProvider<StudentGeneralBloc>(
          create: (_) => sl<StudentGeneralBloc>(),
        ),

        BlocProvider<CenterTrainerBloc>(
          create: (_) => sl<CenterTrainerBloc>(),
        ),
        BlocProvider<CenterGeneralBloc>(
          create: (_) => sl<CenterGeneralBloc>(),
        ),
        BlocProvider<CenterCoursesBloc>(
          create: (_) => sl<CenterCoursesBloc>(),
        ),
        BlocProvider<CenterRequestsBloc>(
          create: (_) => sl<CenterRequestsBloc>(),
        ),
        BlocProvider<TrainerBloc>(create: (_) => sl<TrainerBloc>()),
        BlocProvider<ChatBloc>(create: (_) => sl<ChatBloc>()),
      ],
      child: MaterialApp(
        // showPerformanceOverlay: true,
        theme: ThemeData(scaffoldBackgroundColor: Color(0xFFC39BD3)),
        home: Scaffold(body: SplashPage()),
      ),
    );
  }
}
