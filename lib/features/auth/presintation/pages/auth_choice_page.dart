// import 'package:flutter/material.dart';
// import 'package:grad_project_ver_1/features/auth/presintation/pages/user_type_selection.dart';
// import 'package:grad_project_ver_1/features/auth/presintation/widgets/auth_widget.dart';
// //! WE DONT NEED THIS PAGE ANYMORE
// class AuthChoicePage extends StatelessWidget {
//   const AuthChoicePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Welcome'), centerTitle: true),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildText('You Can Do It', 28,FontWeight.bold),

//             const SizedBox(height: 20),
//             _buildText('Please choose an option below to get started.', 18, FontWeight.normal),
//             const SizedBox(height: 40),
//             _buildActionButton(
//               context: context,
//               label: 'Log In',
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => AuthWidget(doRegister: false),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 20),
//             _buildActionButton(
//               context: context,
//               label: 'Register',
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserTypeSelectionPage(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Text _buildText(String title, double fontsize,FontWeight? fontWeight) {
//     return Text(
//             title,
//             style: TextStyle(fontSize: fontsize,fontWeight: fontWeight ),
//             textAlign: TextAlign.center,
//           );
//   }

//   Widget _buildActionButton({
//     required BuildContext context,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(vertical: 16.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//         ),
//         onPressed: onPressed,
//         child: Text(label, style: const TextStyle(fontSize: 18)),
//       ),
//     );
//   }
// }