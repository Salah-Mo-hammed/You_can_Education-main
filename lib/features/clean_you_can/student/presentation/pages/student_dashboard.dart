// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/core/splash_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_general_bloc/bloc/student_general_bloc_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/student_profile_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/certificates_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/my_learning_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/notifications_widget.dart';
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
  bool _isSearchExpanded = false;
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
          backgroundColor:
              Colors.white, // make scaffold fully transparent

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

          // 🔹 Bottom Navigation Bar with transparency
          // bottomNavigationBar: Theme(
          //   data: Theme.of(context).copyWith(
          //     canvasColor:
          //         Colors.transparent, // transparent background
          //   ),
          //   child: BottomNavigationBar(
          //     backgroundColor: Colors.transparent,
          //     elevation: 0,
          //     currentIndex: _selectedIndex,
          //     onTap: _onTapBottomBar,
          //     selectedItemColor: AppColors.lightGold,
          //     unselectedItemColor: Colors.white70,
          //     items: [
          //       const BottomNavigationBarItem(
          //         label: "Courses",
          //         icon: Icon(Icons.menu_book_rounded),
          //       ),
          //       const BottomNavigationBarItem(
          //         label: "My Learning",
          //         icon: Icon(Icons.bookmark_border),
          //       ),
          //       const BottomNavigationBarItem(
          //         label: "Certificates",
          //         icon: Icon(Icons.done_outline_rounded),
          //       ),

          //       // 🔹 Profile item with image instead of icon
          //       BottomNavigationBarItem(
          //         label: "Profile",
          //         icon: CircleAvatar(
          //           radius: 14,
          //           backgroundColor: Colors.white,
          //           child: ClipOval(
          //             child:
          //                 currentStudent?.photoUrl == null
          //                     ? Image.asset(
          //                       "assets/images/grad_logo.png",
          //                       width: 28,
          //                       height: 28,
          //                       fit: BoxFit.cover,
          //                     )
          //                     : Image.network(
          //                       currentStudent!.photoUrl!,
          //                       width: 28,
          //                       height: 28,
          //                       fit: BoxFit.cover,
          //                       errorBuilder:
          //                           (
          //                             context,
          //                             error,
          //                             stackTrace,
          //                           ) => Image.asset(
          //                             "assets/images/grad_logo.png",
          //                             width: 28,
          //                             height: 28,
          //                             fit: BoxFit.cover,
          //                           ),
          //                     ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),

        // 🟣 Top purple shape
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
        // 🟣 Bottom purple shape
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 110, // adjust height like normal bottom nav
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
                  color:
                      Colors.transparent, // keep background visible
                  child: InkWell(
                    onTap: () => _onTapBottomBar(3),
                    borderRadius: BorderRadius.circular(
                      30,
                    ), // ripple matches circle
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
                            radius:
                                _selectedIndex == 3
                                    ? 18
                                    : 14, // increase radius when selected
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
            duration: const Duration(
              milliseconds: 200,
            ), // animation speed
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(
              isSelected ? 10 : 8,
            ), // increase padding when selected
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? Color(0xFF571874) : Colors.white70,
              size: isSelected ? 28 : 24, // icon also slightly grows
            ),
          ),
        ],
      ),
    );
  }
}
/**
   Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSearchExpanded = !_isSearchExpanded;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: 50,
                          width: _isSearchExpanded ? 220 : 50,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              AnimatedCrossFade(
                                duration: Duration(milliseconds: 200),
                                firstChild: Icon(Icons.search),
                                secondChild: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                                crossFadeState:
                                    !_isSearchExpanded
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                              ),
                              if (_isSearchExpanded) ...[
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "search courses...",
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                
 */

// this is old widget , before the exception incorrect use of parent data widget
/*
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/student_profile_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/certificates_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/my_learning_widget.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/notifications_widget.dart';
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
  bool _isSearchExpanded = false;

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
        return NotificationsWidget();
      default:
        return ShowAvailableCoursesWidget(
          studentId: widget.currentStudentId,
          
        );
    }
  }

 

  @override
  Widget build(BuildContext context) {
    print(
      "**************************************************************-------------------------**************-------------------****************** this is studnet id in student Dashboard ${widget.currentStudentId}",
    );
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          InkWell(
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => StudentProfilePage(studentId:widget.currentStudentId),)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 2,
                child: Row(
                  children: [
                    // User Info
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Icon(Icons.person_off_outlined),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Salah Mohammed",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "Intermediate Level",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    // Search bar
                  ],
                ),
              ),
            ),
          ),

          // Selected Page
          _getSelectedPage(_selectedIndex),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTapBottomBar,
        selectedItemColor: Colors.deepPurple[500],
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            label: "Courses",
            icon: Icon(Icons.menu_book_rounded),
          ),
          BottomNavigationBarItem(
            label: "My Learning",
            icon: Icon(Icons.bookmark_border),
          ),
          BottomNavigationBarItem(
            label: "Certificates",
            icon: Icon(Icons.done_outline_rounded),
          ),
          BottomNavigationBarItem(
            label: "Notifications",
            icon: Icon(Icons.notifications_none),
          ),
        ],
      ),
    );
  }
}
/**
   Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSearchExpanded = !_isSearchExpanded;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: 50,
                          width: _isSearchExpanded ? 220 : 50,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              AnimatedCrossFade(
                                duration: Duration(milliseconds: 200),
                                firstChild: Icon(Icons.search),
                                secondChild: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                                crossFadeState:
                                    !_isSearchExpanded
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                              ),
                              if (_isSearchExpanded) ...[
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "search courses...",
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                
 */
 */
