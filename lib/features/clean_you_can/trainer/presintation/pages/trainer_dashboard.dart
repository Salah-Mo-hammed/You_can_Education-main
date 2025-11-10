import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/features/chat/presintation/pages/trainer_chat_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_course_details_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/bloc/trainer_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/bloc/trainer_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/bloc/trainer_state.dart';

class TrainerDashboardPage extends StatefulWidget {
  final String trainerId;
  const TrainerDashboardPage({super.key, required this.trainerId});

  @override
  State<TrainerDashboardPage> createState() =>
      _TrainerDashboardPageState();
}

class _TrainerDashboardPageState extends State<TrainerDashboardPage> {
  @override
  void initState() {
    super.initState();
    // 🔹 Now we only need one event (fetch trainer + his courses)
    context.read<TrainerBloc>().add(
      getTraienrCoursesEvent(trainerId: widget.trainerId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/trainer_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<TrainerBloc, TrainerState>(
              builder: (context, state) {
                if (state is TrainerLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TrainerGotHisCoursesState) {
                  // 🔹 Extract trainer + courses from state map
                  final trainer = state.trainerCourses['trainer'];
                  final courses =
                      state.trainerCourses['courses']
                          as List<CourseEntity>;
                  int totalCourses = courses.length;
                  int totalStudents = courses.fold(
                    0,
                    (sum, course) =>
                        sum + course.enrolledStudents.length,
                  );
                  int totalSessions = courses.fold(
                    0,
                    (sum, course) => sum + course.urls.length,
                  );

                  return RefreshIndicator(
                    onRefresh: () async {
                      // 🔹 Dispatch event again to reload trainer info + courses
                      context.read<TrainerBloc>().add(
                        getTraienrCoursesEvent(
                          trainerId: widget.trainerId,
                        ),
                      );
                      // Add small delay so indicator stays visible briefly
                      await Future.delayed(
                        const Duration(milliseconds: 600),
                      );
                    },
                    child: ListView(
                      children: [
                        // Header
                        // Row(
                        //   crossAxisAlignment:
                        //       CrossAxisAlignment.center,
                        //   children: [
                        //     CircleAvatar(
                        //       radius: 28,
                        //       backgroundColor: Colors.white
                        //           .withOpacity(0.15),
                        //       child: const Icon(
                        //         Icons.emoji_people,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     const SizedBox(width: 12),
                        //     Column(
                        //       crossAxisAlignment:
                        //           CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           "Hey, ${trainer.name} 👋",
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .titleLarge
                        //               ?.copyWith(color: Colors.white),
                        //         ),
                        //         Text(
                        //           'Trainer',
                        //           style: Theme.of(
                        //             context,
                        //           ).textTheme.bodyMedium?.copyWith(
                        //             color: Colors.white70,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     const Spacer(),
                        //   ],
                        // ),
                        const SizedBox(height: 20),

                        // Stats Cards
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          childAspectRatio: 2.0,
                          children: [
                            _buildStatCard(
                              'Courses',
                              totalCourses.toString(),
                              Icons.menu_book,
                              Color(0xFF571874).withOpacity(0.55),
                            ),
                            _buildStatCard(
                              'Sessions',
                              totalSessions.toString(),
                              Icons.schedule,
                              Color(0xFF571874).withOpacity(0.55),
                            ),
                            _buildStatCard(
                              'Students',
                              totalStudents.toString(),
                              Icons.people_outline,
                              Color(0xFF571874).withOpacity(0.55),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),
                        Text(
                          'Your Courses',
                          style: TextStyle(
                            color: AppColors.grayWhite,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Column(
                          children:
                              courses
                                  .map(
                                    (course) => Column(
                                      children: [
                                        _buildCourseCard(
                                          context,
                                          course: course,
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  )
                                  .toList(),
                        ),
                      ],
                    ),
                  );
                } else if (state is TrainerExceptionState) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 55,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(icon, color: Color(0xFFF2F2F2), size: 40),
            ),
            const SizedBox(width: 12),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: Color(0xFF571874).withOpacity(0.55),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF571874).withOpacity(0.55),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context, {
    required CourseEntity course,
  }) {
    final String? imageUrl = (course as dynamic).imageUrl;

    final bool hasImage =
        imageUrl != null && imageUrl.toString().trim().isNotEmpty;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child:
                  hasImage
                      ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/logofinal.png',
                            fit: BoxFit.contain,
                          );
                        },
                        loadingBuilder: (
                          context,
                          child,
                          loadingProgress,
                        ) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey.shade100,
                            alignment: Alignment.center,
                            child: const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                      )
                      : Image.asset(
                        'assets/images/logofinal.png',
                        fit: BoxFit.fill,
                      ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        course.title,
                        style:
                            Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => TrainerChatsPage(
                                    trainerId: widget.trainerId,
                                  ),
                            ),
                          ),
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.chat,
                          color: Color(0xFF571874),
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${course.enrolledStudents.length} : "Enrolled Students"',
                  style: const TextStyle(
                    color: Color(0xFF571874),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.grey.shade300,
                    color: Color(0xFF571874),
                    minHeight: 12,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CourseDetailsForCenter(
                                  course: course,
                                  isForTrainer: true,
                                ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                0.2,
                              ), // soft black shadow
                              blurRadius:
                                  8, // how blurry the shadow is
                              spreadRadius: 1, // how far it spreads
                              offset: Offset(
                                1,
                                5,
                              ), // (x, y) offset for direction of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFF571874),
                          ),
                        ),
                        child: const Text(
                          'Manage Course',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF571874),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 8),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 10,
                    //     vertical: 6,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xFFF1F3F9),
                    //     borderRadius: BorderRadius.circular(12),
                    //     border: Border.all(color: Color(0xFFE5E7EB)),
                    //   ),
                    //   child: const Text(
                    //     'Details',
                    //     style: TextStyle(color: Colors.black87),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

class TrainerDashboard extends StatelessWidget {
  const TrainerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trainer Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome, Trainer 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            /// Horizontal stats row wrapped in scroll view to avoid overflow
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStatCard('Centers', '5', Icons.location_city),
                  const SizedBox(width: 16),
                  _buildStatCard('Courses', '12', Icons.menu_book),
                  const SizedBox(width: 16),
                  _buildStatCard('Students', '120', Icons.group),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text('My Courses', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildCourseCard(
              title: 'Flutter for Beginners',
              students: 30,
              date: 'May 10, 2025',
            ),
            _buildCourseCard(
              title: 'Advanced Dart',
              students: 18,
              date: 'May 12, 2025',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 12),
            Text(count, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard({required String title, required int students, required String date}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.book, size: 40, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('$students Students\nStarts: $date'),
        isThreeLine: true,
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}


 */
