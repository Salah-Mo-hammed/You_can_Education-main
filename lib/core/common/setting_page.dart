import 'package:flutter/material.dart';

class EditUserInfoPage extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final String? currentImageUrl;

  const EditUserInfoPage({
    Key? key,
    required this.currentName,
    required this.currentPhone,
    this.currentImageUrl,
  }) : super(key: key);

  @override
  _EditUserInfoPageState createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _phoneController = TextEditingController(text: widget.currentPhone);
    _imageUrl = widget.currentImageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Save the updated info
      final updatedName = _nameController.text;
      final updatedPhone = _phoneController.text;

      // You can handle the updated data here
      print('Updated Name: $updatedName');
      print('Updated Phone: $updatedPhone');
      print('Updated Image URL: $_imageUrl');
    }
  }

  void _pickImage() async {
    // Implement image picker logic here
    // For example, using image_picker package
    // After picking the image, update _imageUrl
    setState(() {
      _imageUrl = 'new_image_url'; // Replace with actual image URL
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_imageUrl != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_imageUrl!),
                ),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Add/Change Image'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Mobile Phone',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile phone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}