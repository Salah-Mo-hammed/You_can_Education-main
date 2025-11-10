// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/common_widgets.dart';

class MyLearningWidget extends StatelessWidget {
  final String studentId;

  const MyLearningWidget({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    List<CourseEntity> filteredCourses =
        context
            .read<StudentBloc>()
            .state
            .availableCourses!['filteredCourses'];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 100)),
        SliverToBoxAdapter(
          child: Center(
            child: CommonWidgets().buildHeaderText(
              "My Courses",
              true,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: CommonWidgets().buildSubTitleText(
              "Track your progress and continue learning",
            ),
          ),
        ),

        // In Progress Header in transparent container
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white, // semi-transparent
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(
                    0xFF571874,
                  ).withOpacity(0.28), // border
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  CommonWidgets().buildHeaderText(
                    "In Progress",
                    false,
                  ),
                  const SizedBox(height: 12),

                  // All course cards at once
                  ...List.generate(
                    filteredCourses.isEmpty
                        ? 1
                        : filteredCourses.length,
                    (index) {
                      CourseEntity course =
                          filteredCourses.isEmpty
                              ? CourseEntity(
                                courseId: "courseId",
                                title: "There is no course",
                                description: "description",
                                centerId: "centerId",
                                startDate: DateTime.now(),
                                endDate: DateTime.now(),
                                maxStudents: 55,
                                price: 98,
                                trainerId: 'no trainer',
                                urls: {},
                              )
                              : filteredCourses[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: CommonWidgets().buildCourseCard(
                          currentStudentId: studentId,
                          courses:
                              filteredCourses.isEmpty
                                  ? [course]
                                  : [course],
                          index: 0,
                          inMyLearning: true,
                          context: context,
                          currentStudentName: "student",
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 0),
                ],
              ),
            ),
          ),
        ),

        // SliverList with course cards inside transparent containers
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) {
        //       CourseEntity course =
        //           filteredCourses.isEmpty
        //               ? CourseEntity(
        //                 courseId: "courseId",
        //                 title: "There is no course",
        //                 description: "description",
        //                 centerId: "centerId",
        //                 startDate: DateTime.now(),
        //                 endDate: DateTime.now(),
        //                 maxStudents: 55,
        //                 price: 98,
        //                 trainerId: 'no trainer',
        //                 urls: {},
        //               )
        //               : filteredCourses[index];

        //       return Padding(
        //         padding: const EdgeInsets.symmetric(
        //           horizontal: 16,
        //           vertical: 8,
        //         ),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             color: Colors.white.withOpacity(
        //               0.1,
        //             ), // transparent
        //             borderRadius: BorderRadius.circular(12),
        //             border: Border.all(
        //               color: Colors.white.withOpacity(0.3),
        //               width: 1,
        //             ),
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.black.withOpacity(0.1),
        //                 blurRadius: 6,
        //                 offset: Offset(0, 3),
        //               ),
        //             ],
        //           ),
        //           child: CommonWidgets().buildCourseCard(
        //             currentStudentId: studentId,
        //             courses: [course],
        //             index: 0,
        //             inMyLearning: true,
        //             context: context,
        //             currentStudentName: "student",
        //           ),
        //         ),
        //       );
        //     },
        //     childCount:
        //         filteredCourses.isEmpty ? 1 : filteredCourses.length,
        //   ),
        // ),
      ],
    );
  }
}
