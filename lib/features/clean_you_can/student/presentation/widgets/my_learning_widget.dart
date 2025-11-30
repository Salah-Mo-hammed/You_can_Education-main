// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/course_sessions_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/common_widgets.dart';

class MyLearningWidget extends StatelessWidget {
  final String studentId;

  const MyLearningWidget({super.key, required this.studentId});

  int calculateWeeksBetween(DateTime startDate, DateTime endDate) {
    final duration = endDate.difference(startDate);
    return (duration.inDays / 7).round();
  }

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

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF571874).withOpacity(0.28),
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

                      return InkWell(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => CourseSessionsPage(
                                      courseUrls: course.urls,
                                    ),
                              ),
                            ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.network(
                                  course.imageUrl ??
                                      'https://cdn.pixabay.com/photo/2017/01/10/23/01/code-1970468_1280.jpg',
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
                                    return Image.asset(
                                      'assets/images/grad_logo.png',
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),

                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(
                                            0.6,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 40,
                                  left: 15,
                                  right: 15,
                                  child: Text(
                                    course.title,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                Positioned(
                                  bottom: 15,
                                  left: 15,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${course.enrolledStudents.length} Students",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${calculateWeeksBetween(course.startDate, course.endDate)} weeks",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
      ],
    );
  }
}
