import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

// ignore: must_be_immutable
class AddTrainerPage extends StatelessWidget {
  final String centerId;
  AddTrainerPage({super.key, required this.centerId});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController =
        TextEditingController();
    TextEditingController phoneController = TextEditingController();

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
              "Add Trainer",
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
                      _buildTransparentField("Name", nameController),
                      const SizedBox(height: 12),
                      _buildTransparentField(
                        "Email",
                        emailController,
                      ),
                      const SizedBox(height: 12),
                      _buildTransparentField(
                        "Password",
                        passwordController,
                        obscure: true,
                      ),
                      const SizedBox(height: 12),
                      _buildTransparentField(
                        "Phone",
                        phoneController,
                      ),
                      const SizedBox(height: 12),
                      // ElevatedButton.icon(
                      //   onPressed: () {
                      //     // Handle image upload logic here
                      //   },
                      //   icon: const Icon(
                      //     Icons.image,
                      //     color: Colors.white,
                      //   ),
                      //   label: const Text(
                      //     "Upload Image",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: AppColors.bronze,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                actions: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromARGB(
                          255,
                          139,
                          102,
                          158,
                        ), // purple border
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),

                      backgroundColor: Colors.transparent,

                      /// transparent background
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
                      TrainerEntity newTrainer = TrainerEntity(
                        uid: "",
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        imageUrl: null,
                        coursesId: [],
                        centerId: centerId,
                      );
                      context.read<CenterTrainerBloc>().add(
                        CreateTrainerEvent(
                          newTrainer: newTrainer,
                          password: passwordController.text,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromARGB(
                          255,
                          139,
                          102,
                          158,
                        ), // purple border
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

                      /// transparent background
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Submit",
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

  // Reusable styled TextField
  Widget _buildTransparentField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
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

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grad_project_ver_1/core/colors/app_color.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_bloc.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_event.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

// // ignore: must_be_immutable
// class AddTrainerPage extends StatelessWidget {
//   String centerId;
//   AddTrainerPage({super.key, required this.centerId});

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController nameController = TextEditingController();
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController =
//         TextEditingController();
//     TextEditingController phoneController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(),
//       body: AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(18),
//         ),
//         title: Text(
//           "Add Trainer",
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: AppColors.brown,
//           ),
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   labelText: "Name",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: "Email",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: phoneController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: "phone",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               const SizedBox(height: 12),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   // Handle image upload logic here
//                 },
//                 icon: const Icon(Icons.image),
//                 label: const Text("Upload Image"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.bronze,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text(
//               "Cancel",
//               style: TextStyle(
//                 color: AppColors.mediumGray,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               TrainerEntity newTrainer = TrainerEntity(
//                 uid: "",
//                 name: nameController.text,
//                 email: emailController.text,

//                 phone: phoneController.text,
//                 imageUrl: null,
//                 coursesId: [],
//                 centerId: centerId,
//               );
//               context.read<CenterTrainerBloc>().add(
//                 CreateTrainerEvent(
//                   newTrainer: newTrainer,
//                   password: passwordController.text,
//                 ),
//               );
//               Navigator.of(context).pop();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.bronze,
//             ),
//             child: const Text("Submit"),
//           ),
//         ],
//       ),
//     );
//   }
// }
