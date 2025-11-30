import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_courses_bloc/center_courses_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/add_sourse_session_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/edit_course_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/course_sessions_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

class CourseDetailsForCenter extends StatelessWidget {
  final CourseEntity course;
  final List<TrainerEntity>? trainers;
  final bool isForTrainer;

  const CourseDetailsForCenter({
    super.key,
    required this.course,
    required this.isForTrainer,
    this.trainers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [SizedBox()],
                  ),
                  Center(child: _buildTitle(course.title)),
                  SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                        (course.imageUrl != null &&
                                course.imageUrl!.isNotEmpty)
                            ? Image.network(
                              course.imageUrl!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return Image.asset(
                                  "assets/images/grad_logo.png",
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                            : Image.asset(
                              "assets/images/grad_logo.png",
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildDescription(course.description),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC39BD3),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CourseSessionsPage(
                                    courseUrls: course.urls,
                                  ),
                            ),
                          );
                        },
                        child: const Text(
                          "See sessions",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  _buildInfoCard(
                    Icons.monetization_on,
                    "Price",
                    "\$${course.price.toStringAsFixed(2)}",
                  ),
                  _buildInfoCard(
                    Icons.people,
                    "Max Students",
                    "${course.maxStudents}",
                  ),
                  _buildInfoCard(
                    Icons.calendar_today,
                    "Start Date",
                    _formatDate(course.startDate),
                  ),
                  _buildInfoCard(
                    Icons.event,
                    "End Date",
                    _formatDate(course.endDate),
                  ),
                  _buildInfoCard(
                    Icons.person,
                    "Enrolled Students",
                    "${course.enrolledStudents.length}",
                  ),
                  const SizedBox(height: 16),
                  _buildTopicsSection(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/course_detail_top_shape.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  top: 45,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_sharp),
                    ),
                  ),
                ),
                if (!isForTrainer) ...[
                  Positioned(
                    top: 40,
                    right: 20,

                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.read<CenterCoursesBloc>().add(
                          DeleteCourseEvent(
                            courseId: course.courseId,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 20,

                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => EditCoursePage(
                                  course: course,
                                  availableTrainers: trainers!,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ] else ...[
                  Positioned(
                    top: 40,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => AddCourseSessionPage(
                                  courseId: course.courseId,
                                ),
                          ),
                        );
                      },
                      child: const Text("Add a session"),
                    ),
                  ),
                ],
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/course_detail_bottom_shape.png",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) => Text(
    title,
    style: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Color(0xFF571874),
    ),
  );

  Widget _buildDescription(String description) => Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Text(
      description,
      style: const TextStyle(fontSize: 16, color: Color(0xFF571874)),
    ),
  );

  Widget _buildInfoCard(IconData icon, String label, String value) =>
      Card(
        color: Color(0xFFC39BD3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          title: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF571874),
            ),
          ),
        ),
      );

  Widget _buildTopicsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Topics:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!isForTrainer)
              CircleAvatar(
                radius: 20,
                backgroundColor: Color.fromARGB(255, 189, 145, 206),
                child: IconButton(
                  onPressed:
                      (
                        //! add a topic
                      ) {},
                  icon: Icon(Icons.add, color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        course.topics.isNotEmpty
            ? Column(
              children:
                  course.topics
                      .map(
                        (topic) => Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            title: Text(
                              topic,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            )
            : const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "No topics added for now",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
      ],
    );
  }

  String _formatDate(DateTime? date) =>
      date == null
          ? "Not specified"
          : "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}
