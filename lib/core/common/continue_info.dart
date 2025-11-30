import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/entities/center_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_general_bloc/center_general_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_dashboard_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_general_bloc/bloc/student_general_bloc_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/student_dashboard.dart';

class ContinueInfo extends StatefulWidget {
  final String role;
  final String userId;
  final String email;
  const ContinueInfo({
    super.key,
    required this.role,
    required this.userId,
    required this.email,
  });

  @override
  State<ContinueInfo> createState() => _ContinueInfoState();
}

class _ContinueInfoState extends State<ContinueInfo> {
  final TextEditingController nameController =
      TextEditingController();
  final TextEditingController addressController =
      TextEditingController();
  final TextEditingController phoneController =
      TextEditingController();
  final TextEditingController managerPhoneController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🔹 Background Image
          Positioned.fill(
            child: FadeIn(
              delay: const Duration(milliseconds: 500),
              child: Image.asset(
                "assets/images/auth_background.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 Main Content
          FadeIn(
            delay: const Duration(milliseconds: 1200),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  FadeInUp(
                    delay: const Duration(milliseconds: 1500),
                    child: _buildText(
                      "Complete Your Profile",
                      32,
                      Colors.white,
                      FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInUp(
                    delay: const Duration(milliseconds: 1700),
                    child: Text(
                      "Tell us more about yourself",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Form Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        //when there was boxshadow this should be added Colors.black.withOpacity(
                        //   0.35,
                        // ), // transparent card
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(
                            255,
                            139,
                            102,
                            158,
                          ).withOpacity(0.6),
                        ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: AppColors.gold.withOpacity(0.15),
                        //     blurRadius: 12,
                        //     offset: const Offset(0, 6),
                        //   ),
                        // ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildInfoField(
                              Icons.person_outline,
                              widget.role == "student"
                                  ? "Student Name"
                                  : "Center Name",
                              TextInputType.name,
                              nameController,
                            ),
                            _buildInfoField(
                              Icons.location_on,
                              "Address",
                              TextInputType.text,
                              addressController,
                            ),
                            _buildInfoField(
                              Icons.phone,
                              "Phone Number",
                              TextInputType.phone,
                              phoneController,
                            ),
                            if (widget.role == "center")
                              _buildInfoField(
                                Icons.manage_accounts,
                                "Manager Phone Number",
                                TextInputType.phone,
                                managerPhoneController,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Save button
                  const SizedBox(height: 20),

                  FadeInUp(
                    delay: const Duration(milliseconds: 2000),
                    child: InkWell(
                      onTap: _saveInfo,
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xFFC39BD3),
                        ),
                        child: const Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Go Back button
                  FadeInUp(
                    delay: const Duration(milliseconds: 2200),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            "Go Back",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveInfo() {
    String name = nameController.text.trim();
    String address = addressController.text.trim();
    String phone = phoneController.text.trim();

    if (name.isEmpty || address.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all required fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (widget.role == "student") {
      StudentEntity createStudent = StudentEntity(
        studentId: widget.userId,
        name: name,
        email: widget.email,
        phoneNumber: phone,
        address: address,
        courses: {},
      );
      context.read<StudentGeneralBloc>().add(
        CreateStudentEvent(createStudent: createStudent),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  StudentDashboard(currentStudentId: widget.userId),
        ),
      );
    } else {
      CenterEntity createCenter = CenterEntity(
        centerId: widget.userId,
        name: name,
        email: widget.email,
        phoneNumber: phone,
        address: address,
        description: "no desc for now ",
      );
      context.read<CenterGeneralBloc>().add(
        CreateCenterEvent(createCenter: createCenter),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => CenterDashboard(centerId: widget.userId),
        ),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Information saved successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildInfoField(
    IconData icon,
    String label,
    TextInputType inputType,
    TextEditingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: inputType,
              style: const TextStyle(color: AppColors.lightGray),
              decoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
                labelStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _buildText(
    String text,
    double size,
    Color color,
    FontWeight weight,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
      textAlign: TextAlign.center,
    );
  }
}
