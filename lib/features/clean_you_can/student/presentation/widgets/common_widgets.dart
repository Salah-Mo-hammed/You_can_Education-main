import 'package:flutter/material.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/features/chat/presintation/pages/chat_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_course_details_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/course_details_for_student_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/course_sessions_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/enrolled_course_content_page.dart';

class CommonWidgets {
  // available courses or recent courses
  Padding buildHeaderText(String title, bool needWeight) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF571874),
          fontSize: 28,
          fontWeight:
              needWeight ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Padding buildSubTitleText(String subTitle) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Text(
        subTitle,
        style: TextStyle(color: Color(0xFF571874)),
      ),
    );
  }

  InkWell buildCourseCard({
    required String currentStudentId,
    required List<CourseEntity> courses,
    required int index,
    required bool inMyLearning,
    required BuildContext context,
    String? currentStudentName,
  }) {
    return courses.isEmpty
        ? InkWell(
          child: Center(child: Text(" no courses syudepid student")),
        )
        : InkWell(
          onTap:
              () =>
                  !inMyLearning
                      ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => CourseDetailsForStudent(
                                course: courses[index],
                                studentId: currentStudentId,
                                // isInMyLearning: inMyLearning,
                              ),
                        ),
                      )
                      : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => CourseSessionsPage(
                                courseUrls: courses[index].urls,
                              ),
                        ),
                      ),
          child: Card(
            color: const Color(0xFFB388EB), // light purple background
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(
              horizontal: 100,
              vertical: 6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Image section ---
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      courses[index].imageUrl == null
                          ? "https://imgs.search.brave.com/6uAR6thSuhSUVGjEAgQ2RWvURsGXMKs9IyolxzPGH_Y/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2IzLzM3/LzY0L2IzMzc2NDgx/ZThmOTE3NTZiZmY0/NTg5YTI3MmVhYmYz/LmpwZw"
                          : courses[index].imageUrl!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
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

                // --- Course info section ---
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            courses[index].title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star_border_outlined,
                                color: Colors.white,
                                size: 17,
                              ),
                              Text(
                                "4.8",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        children: const [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.white,
                                size: 16,
                              ),
                              Text(
                                "15Hrs",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.folder,
                                color: Colors.white,
                                size: 16,
                              ),
                              Text(
                                "10 Students",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // // --- Enroll Button ---
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       print(
                      //         "Enroll clicked for ${courses[index].title}",
                      //       );
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Colors.white,
                      //       foregroundColor: const Color(
                      //         0xFF4C1565,
                      //       ), // purple text
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //     ),
                      //     child: const Text("ENROLL"),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }

  Padding buildStack(bool inCertificates) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 12,
      ),
      child: Container(
        height: inCertificates ? 230 : 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.network(
                "https://imgs.search.brave.com/0YgVtL1osBsMJ2uF4LmlLE_N-_lr8dyCCR_Q7Gf4swU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAxLzkyLzAzLzg3/LzM2MF9GXzE5MjAz/ODczMl9ZYTdXSnRi/cldxYWoxb2lFOHF5/WExBYmZwT1V5MXl3/UC5qcGc",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
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
              Positioned(
                bottom: inCertificates ? 85 : 65,
                left: 15,
                child:
                    inCertificates
                        ? CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.star,
                            color: Colors.black,
                          ),
                        )
                        : Text(
                          "Featured",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
              ),
              Positioned(
                bottom: inCertificates ? 60 : 40,
                left: 15,
                child: Text(
                  "Modern Web Development",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),

              Positioned(
                left: 15,
                bottom: 20,
                child: Row(
                  children:
                      inCertificates
                          ? [
                            SizedBox(
                              height: 35,
                              width: 110,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "Preview",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              height: 35,
                              width: 120,

                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.file_download_outlined,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "download",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                          : [
                            Icon(
                              Icons.person_outline_sharp,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "325 Students",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.access_time_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "6 weeks",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
