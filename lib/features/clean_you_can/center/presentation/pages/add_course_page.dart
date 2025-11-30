// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_courses_bloc/center_courses_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

// ignore: must_be_immutable
class AddCoursePage extends StatefulWidget {
  String centerId;
  List<TrainerEntity> availableTrainers;
  AddCoursePage({
    super.key,
    required this.centerId,
    required this.availableTrainers,
  });

  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final TextEditingController titleController =
      TextEditingController();
  final TextEditingController descriptionController =
      TextEditingController();
  final TextEditingController maxStudentsController =
      TextEditingController();
  final TextEditingController priceController =
      TextEditingController();
  final TextEditingController imageUrlController =
      TextEditingController();
  String? selectedTrainerId;
  String? selectedTrainerName;
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _selectDate(
    BuildContext context,
    bool isStartDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/center_dashboard_background_ver2.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              Text(
                "Add Course",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Create New Course",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              AlertDialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),

                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 80),

                      _buildTransparentField(
                        "Title",
                        titleController,
                      ),
                      const SizedBox(height: 12),

                      _buildTransparentField(
                        "Description",
                        descriptionController,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTransparentField(
                              "Max Students",
                              maxStudentsController,
                              isNumber: true,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: _buildTransparentField(
                                "Price",
                                priceController,
                                isNumber: true,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      _buildDatePickerField(
                        label: "Start Date",
                        selectedDate: startDate,
                        onTap: () => _selectDate(context, true),
                      ),
                      const SizedBox(height: 12),
                      _buildDatePickerField(
                        label: "End Date",
                        selectedDate: endDate,
                        onTap: () => _selectDate(context, false),
                      ),
                      const SizedBox(height: 12),
                      _buildTransparentField(
                        "Image Url (optional)",
                        imageUrlController,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          final result = await showModalBottomSheet<
                            String
                          >(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            isScrollControlled: true,
                            builder: (context) {
                              return SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: 40,
                                          height: 4,
                                          margin: EdgeInsets.only(
                                            bottom: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(
                                                  2,
                                                ),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'Select a Trainer',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Flexible(
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          itemCount:
                                              widget
                                                  .availableTrainers
                                                  .length,
                                          separatorBuilder:
                                              (context, index) =>
                                                  Divider(),
                                          itemBuilder: (
                                            context,
                                            index,
                                          ) {
                                            final trainer =
                                                widget
                                                    .availableTrainers[index];
                                            return ListTile(
                                              leading: CircleAvatar(
                                                radius: 25,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        25,
                                                      ),
                                                  child:
                                                      trainer.imageUrl ==
                                                              null
                                                          ? Image.asset(
                                                            'assets/images/grad_logo2.jpg',
                                                            fit:
                                                                BoxFit
                                                                    .fill,
                                                          )
                                                          : Image.asset(
                                                            trainer
                                                                .imageUrl!,
                                                            fit:
                                                                BoxFit
                                                                    .fill,
                                                          ),
                                                ),
                                              ),
                                              title: Text(
                                                trainer.name,
                                              ),
                                              trailing: Icon(
                                                Icons
                                                    .arrow_forward_ios,
                                                size: 16,
                                              ),
                                              onTap: () {
                                                selectedTrainerName =
                                                    trainer.name;
                                                Navigator.pop(
                                                  context,
                                                  trainer.uid,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );

                          if (result != null) {
                            setState(() {
                              selectedTrainerId = result;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(
                            255,
                            139,
                            102,
                            158,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          selectedTrainerName ?? 'Select Trainer',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 139, 102, 158),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),

                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: AppColors.mediumGray,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      final course = CourseEntity(
                        imageUrl: imageUrlController.text,
                        title: titleController.text,
                        description: descriptionController.text,
                        centerId: widget.centerId,
                        startDate: startDate ?? DateTime.now(),
                        endDate: endDate ?? DateTime.now(),
                        maxStudents:
                            int.tryParse(
                              maxStudentsController.text,
                            ) ??
                            0,
                        price:
                            double.tryParse(priceController.text) ??
                            0,
                        courseId: '',
                        trainerId: selectedTrainerId!,
                      );
                      context.read<CenterCoursesBloc>().add(
                        AddCourseEvent(addCourseEntity: course),
                      );
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),

                      backgroundColor: const Color.fromARGB(
                        255,
                        139,
                        102,
                        158,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: AppColors.grayWhite),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Transparent text field
  Widget _buildTransparentField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    bool isNumber = false,
    int maxLines = 1,
  }) {
    const purpleColor = Color(0xFF571874);

    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType:
          isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      style: const TextStyle(color: purpleColor),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(
          color: purpleColor,
          backgroundColor: Colors.white,
        ),
        labelStyle: TextStyle(
          fontSize: isNumber ? 13 : 16,
          color: purpleColor.withOpacity(0.8),
        ),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: purpleColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: purpleColor,
            width: 2.5,
          ),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  // Date picker with transparent style
  Widget _buildDatePickerField({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 139, 102, 158),
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 139, 102, 158),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.5,
            ),
          ),
        ),
        child: Text(
          selectedDate == null
              ? "Select Date"
              : "${selectedDate.toLocal()}".split(' ')[0],
          style: TextStyle(
            fontSize: 16,
            color:
                selectedDate == null
                    ? Color.fromARGB(255, 139, 102, 158)
                    : Color.fromARGB(255, 139, 102, 158),
          ),
        ),
      ),
    );
  }
}
