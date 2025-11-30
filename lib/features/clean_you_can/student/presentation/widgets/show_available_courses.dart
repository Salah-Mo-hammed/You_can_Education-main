import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_state.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/course_details_for_student_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/common_widgets.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ShowAvailableCoursesWidget extends StatefulWidget {
  final String studentId;
  const ShowAvailableCoursesWidget({
    super.key,
    required this.studentId,
  });

  @override
  State<ShowAvailableCoursesWidget> createState() =>
      _ShowAvailableCoursesWidgetState();
}

class _ShowAvailableCoursesWidgetState
    extends State<ShowAvailableCoursesWidget> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  int _selectedButton = -1;

  List<String> categories = [
    "Technology",
    "Language",
    "Business",
    "Health",
  ];

  int calculateWeeksBetween(DateTime startDate, DateTime endDate) {
    final duration = endDate.difference(startDate);
    return (duration.inDays / 7).round();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() {
    context.read<StudentBloc>().add(
      GetAvailableAndMineCoursesEvent(studentId: widget.studentId),
    );
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullDown: true,
      header: WaterDropMaterialHeader(),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          const SizedBox(height: 80),
          Center(
            child: CommonWidgets().buildHeaderText(
              "Available Courses",
              true,
            ),
          ),
          Center(
            child: CommonWidgets().buildSubTitleText(
              "Explore courses to enhance your skills",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildSearchField(onChanged: (value) {}),
          ),
          const SizedBox(height: 10),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(categories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor:
                          _selectedButton == index
                              ? const Color(0xFFC39BD3)
                              : Colors.white,
                      foregroundColor:
                          _selectedButton == index
                              ? Colors.white
                              : Colors.grey[700],
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedButton =
                            _selectedButton == index ? -1 : index;
                      });
                    },
                    child: Text(categories[index]),
                  ),
                );
              }),
            ),
          ),

          BlocBuilder<StudentBloc, StudentState>(
            builder: (context, state) {
              if (state is StudentGotAvailableAndHisCoursesState) {
                final allCourses = state.allCourses;
                List<CourseEntity> enrolledCourses =
                    allCourses['filteredCourses'];
                List<CourseEntity> availableCourses =
                    allCourses['allCourses'];
                List<CourseEntity> nonEnrolledCourses =
                    availableCourses.where((course) {
                      return !enrolledCourses.any(
                        (enrolled) =>
                            enrolled.courseId == course.courseId,
                      );
                    }).toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (nonEnrolledCourses.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 12,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              Image.network(
                                nonEnrolledCourses[0].imageUrl ?? '',
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
                                        Colors.black.withOpacity(0.6),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                bottom: 65,
                                left: 15,
                                child: Text(
                                  "Featured",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 40,
                                left: 15,
                                child: Text(
                                  nonEnrolledCourses[0].title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
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
                                      "${nonEnrolledCourses[0].enrolledStudents.length} Students",
                                      style: const TextStyle(
                                        color: Colors.white,
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
                                      "${calculateWeeksBetween(nonEnrolledCourses[0].startDate, nonEnrolledCourses[0].endDate)} weeks",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    SizedBox(
                      height: 215,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: nonEnrolledCourses.length,
                        // padding: const EdgeInsets.symmetric(
                        //   horizontal: 5,
                        // ),
                        separatorBuilder:
                            (context, _) => const SizedBox(width: 0),
                        itemBuilder: (context, index) {
                          final course = nonEnrolledCourses[index];

                          return SizedBox(
                            width: 200,

                            child: InkWell(
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              CourseDetailsForStudent(
                                                course: course,
                                                studentId:
                                                    widget.studentId,
                                              ),
                                    ),
                                  ),
                              child: Card(
                                color: const Color(
                                  0xFF571874,
                                ).withOpacity(0.55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                ),
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 6,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    // --- Image ---
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 10,
                                          ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        child: Image.network(
                                          course.imageUrl ??
                                              "https://cdn.pixabay.com/photo/2017/01/10/23/01/code-1970468_1280.jpg",
                                          width: double.infinity,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return Image.asset(
                                              'assets/images/grad_logo.png',
                                              width: double.infinity,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    // --- Course Info ---
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                          ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  course.title,
                                                  overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                  style:
                                                      const TextStyle(
                                                        color:
                                                            Colors
                                                                .white,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        fontSize: 15,
                                                      ),
                                                ),
                                              ),
                                              const Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .star_border_outlined,
                                                    color:
                                                        Colors.white,
                                                    size: 16,
                                                  ),
                                                  SizedBox(width: 3),
                                                  Text(
                                                    "4.8",
                                                    style: TextStyle(
                                                      color:
                                                          Colors
                                                              .white,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                            children: const [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time,
                                                    color:
                                                        Colors.white,
                                                    size: 15,
                                                  ),
                                                  // SizedBox(width: 4),
                                                  Text(
                                                    "15Hrs",
                                                    style: TextStyle(
                                                      color:
                                                          Colors
                                                              .white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 10),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .people_outline,
                                                    color:
                                                        Colors.white,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    "10 Students",
                                                    style: TextStyle(
                                                      color:
                                                          Colors
                                                              .white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
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
                    ),
                  ],
                );
              } else if (state is StudentExceptionState) {
                return Center(child: Text(state.message.toString()));
              } else {
                context.read<StudentBloc>().add(
                  GetAvailableAndMineCoursesEvent(
                    studentId: widget.studentId,
                  ),
                );
                return const Center(
                  child: Center(
                    child: SpinKitFadingCube(
                      color: Colors.deepPurple,
                      size: 50.0,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildSearchField({
    String hintText = 'Search...',
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF4C1565)),
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xFF4C1565),
        ),
        filled: true,
        fillColor: Colors.grey[200]!.withOpacity(0.8),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
