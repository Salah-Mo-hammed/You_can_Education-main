// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project_ver_1/core/services/notifications.dart';
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

    print("done sign out");
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
      final userDoc = await firestore.collection('Users').doc(user.uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        final role = userData?['role'];
        final isCompletedInfo = userData?['isCompletedInfo'];

        if (role == "student" && isCompletedInfo == true) {
          // await NotificationService().initFirebaseMessaging(user.uid);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StudentDashboard(
                currentStudentId: userData!['userId'],
              ),
            ),
          );
        } else if (role == "center" && isCompletedInfo == true) {
          // await NotificationService().initFirebaseMessaging(user.uid);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CenterDashboard(centerId: user.uid),
            ),
          );
        } else if (role == "Trainer" && isCompletedInfo == true) {
          // await NotificationService().initFirebaseMessaging(user.uid);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TrainerDashboardPage(trainerId: user.uid),
            ),
          );
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
        duration: Duration(milliseconds:1200 ),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash_background.png"), // Your background
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
                    'assets/images/splash_logo.png', // Your YC YouCan logo
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

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:grad_project_ver_1/core/colors/app_color.dart';
// import 'package:grad_project_ver_1/core/services/notifications.dart';
// import 'package:grad_project_ver_1/features/auth/presintation/widgets/auth_widget.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_dashboard_page.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/student_dashboard.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/pages/trainer_dashboard.dart';
// import 'package:newton_particles/newton_particles.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SplashPageState createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   double _opacity =
//       0.0; //  to Start center image completely invisible

//   @override
//   void initState() {
//     // uncomment this to stop auto sign in

//     // FirebaseAuth.instance.signOut();
//     print("done sugn out");
//     super.initState();
//     // Fade-in the center image
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() {
//         _opacity = 1.0;
//       });

//       // After 2 seconds => fade-out the center image
//       Future.delayed(const Duration(seconds: 2), () {
//         setState(() {
//           _opacity = 0.0;
//         });

//         // After the fade-out completes, check if user is already checked in
//         Future.delayed(const Duration(seconds: 1), () {
//           _checkLoginStatus();
//         });
//       });
//     });
//   }

//   void _checkLoginStatus() async {
//     final user = FirebaseAuth.instance.currentUser;
//     final firestore = FirebaseFirestore.instance;
//     if (user != null) {
//       final userDoc =
//           await firestore
//               .collection('Users')
//               .doc(user.uid.toString())
//               .get();
//       if (userDoc.exists) {
//         final userData = userDoc.data();
//         final role = userData?['role'];

//         final isCompletedInfo = userData?['isCompletedInfo'];

//         if (role == "student" && isCompletedInfo == true) {
//           // ignore: avoid_print
//           print(
//             "**********************************************************************************************************  user id in splash page is ${userData!['userId']}",
//           );
//           Navigator.pushReplacement(
//             // ignore: use_build_context_synchronously
//             context,
//             MaterialPageRoute(
//               builder:
//                   (context) => StudentDashboard(
//                     currentStudentId: userData['userId'],
//                   ),
//             ),
//           );
//         } else if (role == "center" && isCompletedInfo == true) {
//           //! NotificationService method 
//             await NotificationService().initFirebaseMessaging(user.uid);

//           Navigator.pushReplacement(
//             // ignore: use_build_context_synchronously
//             context,
//             MaterialPageRoute(
//               builder:
//                   (context) => CenterDashboard(centerId: user.uid),
//             ),
//           );
//         } else if (role == "Trainer" && isCompletedInfo == true) {
//           Navigator.pushReplacement(
//             // ignore: use_build_context_synchronously
//             context,
//             MaterialPageRoute(
//               builder: (context) =>  TrainerDashboardPage(trainerId: user.uid,),
//             ), // if role is not stu or center (by accident)
//           );
//         } else {
//           Navigator.pushReplacement(
//             // ignore: use_build_context_synchronously
//             context,
//             MaterialPageRoute(
//               builder:
//                   (context) => const AuthWidget(doRegister: false),
//             ), // if role is not stu or center (by accident)
//           );
//         }
//       }
//       //! for the problem(when adding trainer , we make an account for him , change it when you make page for him or when trainer clean arch is done)
//       else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const AuthWidget(doRegister: false),
//           ), // after done evry thing in home page swip it to => AuthChoicePage
//         );
//       }
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const AuthWidget(doRegister: false),
//         ), // after done evry thing in home page swip it to => AuthChoicePage
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightGray,
//       body: SafeArea(
//         child: Newton(
//           child: Center(
//             child: AnimatedOpacity(
//               duration: const Duration(seconds: 1),
//               opacity: _opacity,
//               child: CircleAvatar(
//                 radius: 100,
//                 backgroundColor: AppColors.lightGray,
//                 child: ClipOval(
//                   child: SizedBox(
//                     width: 180,
//                     height: 180,
//                     child: Image.asset(
//                       'assets/images/grad_logo.png',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
