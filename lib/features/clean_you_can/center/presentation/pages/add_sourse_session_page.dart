import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_courses_bloc/center_courses_bloc.dart';

class AddCourseSessionPage extends StatelessWidget {
  String courseId;
  AddCourseSessionPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final urlController = TextEditingController();

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Add Session',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: FadeIn(
              delay: const Duration(milliseconds: 500),
              child: Image.asset(
                "assets/images/trainer_background.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: titleController,
                    label: 'Session Title',
                    hintText: 'e.g., Introduction to Flutter',
                    icon: Icons.title,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: urlController,
                    label: 'Session URL',
                    hintText: 'e.g., https://zoom.us/your-session',
                    icon: Icons.link,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.add,
                        color: Color(0xFF571874).withOpacity(0.5),
                      ),
                      label: Text(
                        'Add Session',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF571874).withOpacity(0.5),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        context.read<CenterCoursesBloc>().add(
                          AddCourseSessionEvent(
                            courseId: courseId,
                            sessionTitle: titleController.text,
                            sessionUrl: urlController.text,
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        labelText: label,
        hintText: hintText,
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),

        filled: true,
        fillColor: Color(0xFFF2F2F2).withOpacity(0.5),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(17),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(17),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
    );
  }
}
