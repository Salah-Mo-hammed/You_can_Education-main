import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/domain/entities/student_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_general_bloc/bloc/student_general_bloc_bloc.dart';

class EditStudentProfilePage extends StatefulWidget {
  final StudentEntity studentInfo;

  const EditStudentProfilePage({
    super.key,
    required this.studentInfo,
  });

  @override
  State<EditStudentProfilePage> createState() =>
      _EditCenterProfilePageState();
}

class _EditCenterProfilePageState
    extends State<EditStudentProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;

  late TextEditingController _photoUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.studentInfo.name,
    );
    _addressController = TextEditingController(
      text: widget.studentInfo.address,
    );
    _phoneController = TextEditingController(
      text: widget.studentInfo.phoneNumber,
    );

    _photoUrlController = TextEditingController(
      text: widget.studentInfo.photoUrl ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Student Info"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Name", _nameController),
              _buildTextField("Address", _addressController),
              _buildTextField(
                "Phone Number",
                _phoneController,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField("Image URL", _photoUrlController),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  StudentEntity updatedStudentInfo = StudentEntity(
                    studentId: widget.studentInfo.studentId,
                    name:
                        _nameController.text.isEmpty
                            ? widget.studentInfo.name
                            : _nameController.text,
                    email: widget.studentInfo.email,
                    phoneNumber:
                        _phoneController.text.isEmpty
                            ? widget.studentInfo.phoneNumber
                            : _phoneController.text,
                    address:
                        _addressController.text.isEmpty
                            ? widget.studentInfo.address
                            : _addressController.text,
                    photoUrl:
                        _photoUrlController.text.isEmpty
                            ? widget.studentInfo.photoUrl
                            : _photoUrlController.text,
                  );

                  context.read<StudentGeneralBloc>().add(
                    UpdateStudentInfoEvent(
                      updateStudent: updatedStudentInfo,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
                value == null || value.trim().isEmpty
                    ? "Please enter $label"
                    : null,
      ),
    );
  }
}
