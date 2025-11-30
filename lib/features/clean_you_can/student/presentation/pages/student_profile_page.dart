import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_event.dart';
import 'package:grad_project_ver_1/features/auth/presintation/widgets/auth_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_general_bloc/bloc/student_general_bloc_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/edit_student_info_page.dart';

class StudentProfilePage extends StatelessWidget {
  final String studentId;
  const StudentProfilePage({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // make scaffold transparent so background shows
      backgroundColor: Colors.transparent,
      body: BlocBuilder<StudentGeneralBloc, StudentGeneralState>(
        builder: (context, state) {
          if (state is StudentGeneralLoadingState) {
            return const Center(
              child: Center(
                child: SpinKitFadingCube(
                  color: Colors.deepPurple,
                  size: 50.0,
                ),
              ),
            );
          } else if (state is StudentGeneralGotInfoState) {
            final studentinfo = state.currentStudent;

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 150),
                  // ===== HEADER WITH GRADIENT =====
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child:
                              studentinfo.photoUrl == null
                                  ? Image.asset(
                                    "assets/images/grad_logo.png",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.network(
                                    studentinfo.photoUrl!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (
                                          context,
                                          error,
                                          stackTrace,
                                        ) => Image.asset(
                                          "assets/images/grad_logo.png",
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                  ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        studentinfo.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF571874),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ===== INFO CARDS =====
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xFFC39BD3),
                      ),
                      child: _buildInfoCard(
                        icon: Icons.location_on,
                        iconColor: Colors.white,
                        title: "Address",
                        content: studentinfo.address,
                        delay: 100,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xFFC39BD3),
                      ),
                      child: _buildInfoCard(
                        icon: Icons.email,
                        iconColor: Colors.white,
                        title: "Email",
                        content: studentinfo.email,
                        delay: 200,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xFFC39BD3),
                      ),
                      child: _buildInfoCard(
                        icon: Icons.phone,
                        iconColor: Colors.white,
                        title: "Phone Number",
                        content: studentinfo.phoneNumber,
                        delay: 300,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== EDIT BUTTON =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            context.read<AuthBloc>().add(
                              AuthLogOutEvent(),
                            );
                            // context.read<StudentGeneralBloc>().add(
                            //   LogOutStudentEvent(),
                            // );
                            context.read<StudentBloc>().add(
                              LogOutStudentDoEvent(),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        AuthWidget(doRegister: false),
                              ),
                            );
                          },
                          icon: const Icon(Icons.login_outlined),
                          label: const Text("Sign Out"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC39BD3),
                            foregroundColor: Color(0xFF571874),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => EditStudentProfilePage(
                                      studentInfo: studentinfo,
                                    ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit Profile"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC39BD3),
                            foregroundColor: Color(0xFF571874),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            );
          } else if (state is StudentGeneralExceptionState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 50,
                    color: Colors.red.shade700,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<StudentGeneralBloc>().add(
                        GetStudentInfoEvent(studentId: studentId),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Retry"),
                  ),
                ],
              ),
            );
          } else {
            context.read<StudentGeneralBloc>().add(
              GetStudentInfoEvent(studentId: studentId),
            );
            return const Center(
              child: Center(
                child: SpinKitFadingCube(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // Helper method to build info cards
  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
    required int delay,
  }) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: delay),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 22, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF571874),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
