// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project_ver_1/features/auth/presintation/widgets/auth_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_dashboard_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/student_dashboard.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/pages/trainer_dashboard.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 0.0;

  @override
  void initState() {
    // uncomment this to stop auto sign in
    // FirebaseAuth.instance.signOut();
    // print("done sign out");
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _opacity = 0.0;
        });

        Future.delayed(const Duration(seconds: 1), () {
          _checkLoginStatus();
        });
      });
    });
  }

  void _checkLoginStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    final firestore = FirebaseFirestore.instance;
    if (user != null) {
      final userDoc =
          await firestore.collection('Users').doc(user.uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        final role = userData?['role'];
        final isCompletedInfo = userData?['isCompletedInfo'];

        if (role == "student" && isCompletedInfo == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => StudentDashboard(
                    currentStudentId: userData!['userId'],
                  ),
            ),
          );
        } else if (role == "center" && isCompletedInfo == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => CenterDashboard(centerId: user.uid),
            ),
          );
        } else if (role == "Trainer" && isCompletedInfo == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      TrainerDashboardPage(trainerId: user.uid),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => const AuthWidget(doRegister: false),
            ),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthWidget(doRegister: false),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthWidget(doRegister: false),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeIn(
        duration: Duration(milliseconds: 1200),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/splash_background.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _opacity,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/images/splash_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
