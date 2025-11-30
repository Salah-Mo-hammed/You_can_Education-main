import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/entities/center_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_general_bloc/center_general_bloc.dart';

class EditCenterProfilePage extends StatefulWidget {
  final CenterEntity centerInfo;

  const EditCenterProfilePage({super.key, required this.centerInfo});

  @override
  State<EditCenterProfilePage> createState() =>
      _EditCenterProfilePageState();
}

class _EditCenterProfilePageState
    extends State<EditCenterProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.centerInfo.name,
    );
    _addressController = TextEditingController(
      text: widget.centerInfo.address,
    );
    _phoneController = TextEditingController(
      text: widget.centerInfo.phoneNumber,
    );
    _emailController = TextEditingController(
      text: widget.centerInfo.email,
    );
    _descriptionController = TextEditingController(
      text: widget.centerInfo.description,
    );
    _imageUrlController = TextEditingController(
      text: widget.centerInfo.imageUrl ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
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
        child: Column(
          children: [
            SizedBox(height: 110),
            Text(
              "Edit Center Info",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 110),
            Center(
              child: AlertDialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),

                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTransparentField("Name", _nameController),
                      const SizedBox(height: 12),
                      _buildTransparentField(
                        "Address",
                        _addressController,
                      ),
                      const SizedBox(height: 12),
                      _buildTransparentField(
                        "Phone",
                        _phoneController,
                      ),
                      const SizedBox(height: 12),
                      _buildTransparentField(
                        "Email",
                        _emailController,
                      ),
                      const SizedBox(height: 12),
                      _buildTransparentField(
                        "Description",
                        _descriptionController,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 12),
                      _buildTransparentField(
                        "Image URL",
                        _imageUrlController,
                      ),
                    ],
                  ),
                ),
                actions: [
                  OutlinedButton(
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
                      CenterEntity updatedCenterInfo = CenterEntity(
                        centerId: widget.centerInfo.centerId,
                        name:
                            _nameController.text.isEmpty
                                ? widget.centerInfo.name
                                : _nameController.text,
                        email: widget.centerInfo.email,
                        phoneNumber:
                            _phoneController.text.isEmpty
                                ? widget.centerInfo.phoneNumber
                                : _phoneController.text,
                        address:
                            _addressController.text.isEmpty
                                ? widget.centerInfo.address
                                : _addressController.text,
                        description:
                            _descriptionController.text.isEmpty
                                ? widget.centerInfo.description
                                : _descriptionController.text,
                        imageUrl: _imageUrlController.text,
                      );
                      context.read<CenterGeneralBloc>().add(
                        UpdateCenterInfoEvent(
                          updatedCenter: updatedCenterInfo,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 139, 102, 158),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),

                      backgroundColor: Color.fromARGB(
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
                      "Save Changes",
                      style: TextStyle(color: AppColors.grayWhite),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransparentField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      maxLines: maxLines,
      style: const TextStyle(
        color: Color.fromARGB(255, 139, 102, 158),
      ),
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
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}
