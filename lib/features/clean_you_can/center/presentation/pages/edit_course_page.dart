import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_courses_bloc/center_courses_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

class EditCoursePage extends StatefulWidget {
  final CourseEntity course;
  List<TrainerEntity> availableTrainers;
  EditCoursePage({
    super.key,
    required this.course,
    required this.availableTrainers,
  });

  @override
  _EditCoursePageState createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _maxStudentsController;
  late DateTime _startDate;
  late DateTime _endDate;
  String? selectedTrainerId;
  String? selectedTrainerName;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.course.title,
    );
    _descriptionController = TextEditingController(
      text: widget.course.description,
    );
    _priceController = TextEditingController(
      text: widget.course.price.toString(),
    );
    _maxStudentsController = TextEditingController(
      text: widget.course.maxStudents.toString(),
    );
    _startDate = widget.course.startDate;
    _endDate = widget.course.endDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _maxStudentsController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = isStartDate ? _startDate : _endDate;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Course"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Title", _titleController),
              _buildTextField(
                "Description",
                _descriptionController,
                maxLines: 3,
              ),
              _buildTextField(
                "Price (\$)",
                _priceController,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                "Max Students",
                _maxStudentsController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              _buildDatePicker(
                "Start Date",
                _startDate,
                () => _selectDate(context, true),
              ),
              _buildDatePicker(
                "End Date",
                _endDate,
                () => _selectDate(context, false),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await showModalBottomSheet<String>(
                    context: context,
                    builder: (context) {
                      return ListView(
                        children:
                            widget.availableTrainers.map((trainer) {
                              return ListTile(
                                title: Text(trainer.name),
                                onTap: () {
                                  selectedTrainerName = trainer.name;
                                  Navigator.pop(context, trainer.uid);
                                },
                              );
                            }).toList(),
                      );
                    },
                  );

                  if (result != null) {
                    setState(() {
                      selectedTrainerId = result;
                    });
                  }
                },
                child: Text(selectedTrainerName ?? 'select trainer'),
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  CourseEntity updatedCourse = CourseEntity(
                    courseId: widget.course.courseId,
                    title: _titleController.text.trim(),
                    description: _descriptionController.text.trim(),
                    price: double.parse(_priceController.text.trim()),
                    maxStudents: int.parse(
                      _maxStudentsController.text.trim(),
                    ),
                    startDate: _startDate,
                    endDate: _endDate,
                    enrolledStudents:
                        widget
                            .course
                            .enrolledStudents, // same students
                    topics: widget.course.topics, // same topics
                    imageUrl: widget.course.imageUrl,
                    centerId: widget.course.centerId,
                    trainerId: selectedTrainerId!,
                    urls: widget.course.urls,
                  );

                  context.read<CenterCoursesBloc>().add(
                    UpdateCourseEvent(
                      updateCourseEntity: updatedCourse,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator:
            (value) =>
                value == null || value.isEmpty
                    ? "Please enter $label"
                    : null,
      ),
    );
  }

  Widget _buildDatePicker(
    String label,
    DateTime date,
    VoidCallback onTap,
  ) {
    return ListTile(
      title: Text(label),
      subtitle: Text(
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      ),
      trailing: const Icon(
        Icons.calendar_today,
        color: Colors.blueAccent,
      ),
      onTap: onTap,
    );
  }
}
