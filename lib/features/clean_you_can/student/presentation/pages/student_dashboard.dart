// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_general_bloc/bloc/student_general_bloc_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/student_profile_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/certificates_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/my_learning_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/show_available_courses.dart';

// ignore: must_be_immutable
class StudentDashboard extends StatefulWidget {
  String currentStudentId;
  StudentDashboard({super.key, required this.currentStudentId});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;
  StudentEntity? currentStudent;

  @override
  void initState() {
    super.initState();
    context.read<StudentGeneralBloc>().add(
      GetStudentInfoEvent(studentId: widget.currentStudentId),
    );
  }

  void _onTapBottomBar(int tempIndex) {
    setState(() {
      _selectedIndex = tempIndex;
    });
  }

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return ShowAvailableCoursesWidget(
          studentId: widget.currentStudentId,
        );
      case 1:
        return MyLearningWidget(studentId: widget.currentStudentId);
      case 2:
        return CertificatesWidget();
      case 3:
        return StudentProfilePage(studentId: widget.currentStudentId);
      default:
        return ShowAvailableCoursesWidget(
          studentId: widget.currentStudentId,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,

          body: BlocListener<StudentGeneralBloc, StudentGeneralState>(
            listener: (context, state) {
              if (state is StudentGeneralGotInfoState) {
                setState(() {
                  currentStudent = state.currentStudent;
                });
              }
            },
            child: _getSelectedPage(_selectedIndex),
          ),
        ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            "assets/images/course_detail_top_shape.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/course_detail_bottom_shape.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNavItem(
                  icon: Icons.menu_book_rounded,
                  label: "Courses",
                  index: 0,
                ),
                _buildNavItem(
                  icon: Icons.bookmark_border,
                  label: "My Learning",
                  index: 1,
                ),
                _buildNavItem(
                  icon: Icons.done_outline_rounded,
                  label: "Certificates",
                  index: 2,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _onTapBottomBar(3),
                    borderRadius: BorderRadius.circular(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.all(
                            _selectedIndex == 3 ? 4 : 0,
                          ),
                          child: CircleAvatar(
                            radius: _selectedIndex == 3 ? 18 : 14,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child:
                                  currentStudent?.photoUrl == null
                                      ? Image.asset(
                                        "assets/images/grad_logo.png",
                                        width: 28,
                                        height: 28,
                                        fit: BoxFit.cover,
                                      )
                                      : Image.network(
                                        currentStudent!.photoUrl!,
                                        width: 28,
                                        height: 28,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (
                                              context,
                                              error,
                                              stackTrace,
                                            ) => Image.asset(
                                              "assets/images/grad_logo.png",
                                              width: 28,
                                              height: 28,
                                              fit: BoxFit.cover,
                                            ),
                                      ),
                            ),
                          ),
                        ),
                        // if (_selectedIndex == 3)
                        //   Container(
                        //     margin: const EdgeInsets.only(top: 4),
                        //     height: 3,
                        //     width: 20,
                        //     color: AppColors.lightGold,
                        //   ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onTapBottomBar(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(isSelected ? 10 : 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? Color(0xFF571874) : Colors.white70,
              size: isSelected ? 28 : 24,
            ),
          ),
        ],
      ),
    );
  }
}
