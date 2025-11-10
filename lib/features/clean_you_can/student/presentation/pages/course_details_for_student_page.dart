import 'package:flutter/material.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/confirm_enrollment_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/course_sessions_page.dart';

class CourseDetailsForStudent extends StatelessWidget {
  final CourseEntity course;
  final String studentId;
  // final bool isInMyLearning;
  const CourseDetailsForStudent({
    super.key,
    required this.course,
    required this.studentId,
    // required this.isInMyLearning,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          course.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // if (!isInMyLearning) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder:
                //           (context) => ConfirmEnrollmentPage(
                //             currentStudentId: studentId,
                //             selcetedCourse: course,
                //           ),
                //     ),
                //   );
                // }
                // else {
                if (!course.enrolledStudents.contains(studentId)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ConfirmEnrollmentPage(
                            currentStudentId: studentId,
                            selcetedCourse: course, 
                          ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CourseSessionsPage(
                            courseUrls: course.urls,
                          ),
                    ),
                  );
                }

                // }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text(
                  (!course.enrolledStudents.contains(studentId) ||
                          course.enrolledStudents.isEmpty)
                      ? "Enrolle"
                      : " see sessions ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: _buildCourseDetails(),
    );
  }

  Widget _buildCourseDetails() {
    if(course.imageUrl==null)
              print('******************************************************* image is null}');
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if (course.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                course.imageUrl!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 16),
          _buildTitle(course.title),
          _buildDescription(course.description),
          const SizedBox(height: 16),
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
        ],
      ),
    );
  }

  Widget _buildTitle(String title) => Text(
    title,
    style: const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  );
  Widget _buildDescription(String description) => Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Text(
      description,
      style: const TextStyle(fontSize: 18, color: Colors.black54),
    ),
  );
  Widget _buildInfoCard(IconData icon, String label, String value) =>
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blueGrey,
            ),
          ),
        ),
      );

  Widget _buildTopicsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Topics:",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
