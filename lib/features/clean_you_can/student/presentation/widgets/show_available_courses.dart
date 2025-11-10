import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_state.dart';
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
    "Buisness",
    "Health",
  ];

  int calculateWeeksBetween(DateTime startDate, DateTime endDate) {
    final duration = endDate.difference(startDate);
    return (duration.inDays / 7)
        .round(); // Use .ceil() if you want to always round up
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
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 100)),
          SliverToBoxAdapter(
            child: Center(
              child: CommonWidgets().buildHeaderText(
                "Available Courses",
                true,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: CommonWidgets().buildSubTitleText(
                "Explore courses to enhance your skills",
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildSearchField(onChanged: (value) {}),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          //! categories buttons
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(4, (index) {
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
                                ? Color(0xFFC39BD3)
                                : Color(0xFFFFFFFF),
                        foregroundColor:
                            _selectedButton == index
                                ? Colors.white
                                : Colors.grey[700],
                      ),
                      onPressed: () {
                        setState(() {
                          if (_selectedButton == index) {
                            _selectedButton = -1;
                          } else {
                            _selectedButton = index;
                          }
                        });
                      },
                      child: Text(categories[index]),
                    ),
                  );
                }),
              ),
            ),
          ),

          //!  List of Cards
          BlocBuilder<StudentBloc, StudentState>(
            builder: (context, state) {
              if (state is StudentGotAvailableAndHisCoursesState) {
                final allCourses = state.allCourses;
                //! we made this , because after student enroll in course , the course status is pending , so best way to not pay again for same course is by just show nonenrolledcourses
                //! here i have the all courses and enrolled courses , i just make all courses - enrolled courses = non enrolledcourses (these what we will show in available courses)
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
                return SliverList(
                  delegate: SliverChildListDelegate([
                    /// Featured course
                    (nonEnrolledCourses.isNotEmpty)
                        ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 12,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.network(
                                  // nonEnrolledCourses[0].imageUrl != null && nonEnrolledCourses[0].imageUrl!.isNotEmpty
                                  // ?
                                  nonEnrolledCourses[0].imageUrl!,
                                  // : "https://imgs.search.brave.com/6uAR6thSuhSUVGjEAgQ2RWvURsGXMKs9IyolxzPGH_Y/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2IzLzM3/LzY0L2IzMzc2NDgx/ZThmOTE3NTZiZmY0/NTg5YTI3MmVhYmYz/LmpwZw",
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
                                    style: TextStyle(
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
                                      Icon(
                                        Icons.person_outline,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${nonEnrolledCourses[0].enrolledStudents.length} Students",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${calculateWeeksBetween(nonEnrolledCourses[0].startDate, nonEnrolledCourses[0].endDate)} weeks",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        : SizedBox(),

                    /// Header for recent courses
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          CommonWidgets().buildHeaderText(
                            "Recent Courses",
                            true,
                          ),
                        ],
                      ),
                    ),

                    /// Course cards
                    ...List.generate(nonEnrolledCourses.length, (
                      index,
                    ) {
                      return CommonWidgets().buildCourseCard(
                        currentStudentId: widget.studentId,
                        courses: nonEnrolledCourses,
                        index: index,
                        inMyLearning: false,
                        context: context,
                      );
                    }),
                    SizedBox(height: 120),
                  ]),
                );
              } else if (state is StudentExceptionState) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(state.message.toString()),
                  ),
                );
              } else {
                context.read<StudentBloc>().add(
                  GetAvailableAndMineCoursesEvent(
                    studentId: widget.studentId,
                  ),
                );

                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 200),
                      Center(child: CircularProgressIndicator()),
                    ],
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
        hintStyle: TextStyle(color: Color(0xFF4C1565)),
        prefixIcon: Icon(Icons.search, color: Color(0xFF4C1565)),
        filled: true,
        fillColor: Colors.grey[200]!.withOpacity(0.8),
        contentPadding: EdgeInsets.symmetric(
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
