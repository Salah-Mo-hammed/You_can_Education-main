// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grad_project_ver_1/features/chat/presintation/pages/trainer_chat_page.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_course_details_page.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/bloc/trainer_bloc.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/bloc/trainer_event.dart';
// import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/bloc/trainer_state.dart';

// class TrainerDashboardPage extends StatelessWidget {
//   String trainerId;
//   TrainerDashboardPage({super.key, required this.trainerId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: false,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20),
//           ),
//         ),
//         title: Row(
//           children: [
//             Container(
//               height: 36,
//               width: 36,
//               decoration: BoxDecoration(
//                 color: Colors.indigo.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Icon(
//                 Icons.menu_book,
//                 color: Colors.indigo,
//               ),
//             ),
//             const SizedBox(width: 10),
//             Text(
//               'TrainerHub',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ],
//         ),
//         actions: [
//           _roundIconButton(
//             icon: Icons.notifications_none,
//             onTap: () {},
//           ),
//           const SizedBox(width: 8),
//           _roundIconButton(
//             icon: Icons.message_outlined,
//             onTap: () {},
//           ),
//           const SizedBox(width: 12),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             // Header
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.indigo.shade500,
//                     Colors.indigo.shade700,
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.indigo.withOpacity(0.15),
//                     blurRadius: 20,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 28,
//                     backgroundColor: Colors.white.withOpacity(0.15),
//                     child: const Icon(
//                       Icons.emoji_people,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Hey, John Doe 👋',
//                         style: Theme.of(context).textTheme.titleLarge
//                             ?.copyWith(color: Colors.white),
//                       ),
//                       Text(
//                         'Trainer',
//                         style: Theme.of(context).textTheme.bodyMedium
//                             ?.copyWith(color: Colors.white70),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.white24),
//                     ),
//                     child: Row(
//                       children: const [
//                         Icon(
//                           Icons.check_circle,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                         SizedBox(width: 6),
//                         Text(
//                           'Active',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             // Stats Cards
//             GridView.count(
//               crossAxisCount: 2,
//               shrinkWrap: true,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//               physics: const NeverScrollableScrollPhysics(),
//               childAspectRatio: 2.2,
//               children: [
//                 _buildStatCard(
//                   'Courses',
//                   '12',
//                   Icons.menu_book,
//                   Colors.indigo,
//                 ),
//                 _buildStatCard(
//                   'Students',
//                   '260',
//                   Icons.group,
//                   Colors.teal,
//                 ),
//                 _buildStatCard(
//                   'Progress',
//                   '78%',
//                   Icons.show_chart,
//                   Colors.orange,
//                 ),
//                 _buildStatCard(
//                   'Sessions',
//                   '134',
//                   Icons.schedule,
//                   Colors.pink,
//                 ),
//               ],
//             ),

//             const SizedBox(height: 32),
//             Text(
//               'Your Courses',
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             const SizedBox(height: 16),

//             BlocBuilder<TrainerBloc, TrainerState>(
//               builder: (context, state) {
//                 if (state is TrainerInitialState) {
//                   context.read<TrainerBloc>().add(
//                     getTraienrInfoEvent(trainerId: trainerId),
//                   );

//                   return const Center(
//                     child: Text(
//                       'Welcome! Please wait while we load your data.',
//                     ),
//                   );
//                 } else if (state is TrainerLoadingState) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state is TrainerGotHisInfoState) {
//                   print(
//                     " *********************** welcom ${state.trainer.name}",
//                   );
//                   context.read<TrainerBloc>().add(
//                     getTraienrCoursesEvent(trainerId: trainerId),
//                   );
//                   return Center(
//                     child: Text("welcom ${state.trainer.name}"),
//                   );
//                 } else if (state is TrainerGotHisCoursesState) {
//                   final courses = state.trainerCourses;
//                   return Column(
//                     children:
//                         courses.map((course) {
//                           return Column(
//                             children: [
//                               _buildCourseCard(
//                                 context,
//                                 course: course,
//                               ),
//                               const SizedBox(height: 16),
//                             ],
//                           );
//                         }).toList(),
//                   );
//                 } else if (state is TrainerExceptionState) {
//                   return Center(
//                     child: Text(
//                       state.errorMessage,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   );
//                 } else {
//                   return const SizedBox.shrink();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _roundIconButton({
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: const Color(0xFFF1F3F9),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: const Color(0xFFE5E7EB)),
//         ),
//         child: Icon(icon, color: Colors.black87),
//       ),
//     );
//   }

//   Widget _buildStatCard(
//     String title,
//     String value,
//     IconData icon,
//     Color color,
//   ) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: color),
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   title,
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCourseCard(
//     BuildContext context, {
//     required CourseEntity course,
//   }) {
//     final String? imageUrl =
//         (course as dynamic).imageUrl; // non-breaking access
//     final bool hasImage =
//         imageUrl != null && imageUrl.toString().trim().isNotEmpty;

//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(
//               top: Radius.circular(16),
//             ),
//             child: SizedBox(
//               height: 160,
//               width: double.infinity,
//               child:
//                   hasImage
//                       ? Image.network(
//                         imageUrl!,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Image.asset(
//                             'assets/images/grad_logo.png',
//                             fit: BoxFit.contain,
//                           );
//                         },
//                         loadingBuilder: (
//                           context,
//                           child,
//                           loadingProgress,
//                         ) {
//                           if (loadingProgress == null) return child;
//                           return Container(
//                             color: Colors.grey.shade100,
//                             alignment: Alignment.center,
//                             child: const SizedBox(
//                               height: 24,
//                               width: 24,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                               ),
//                             ),
//                           );
//                         },
//                       )
//                       : Image.asset(
//                         'assets/images/grad_logo.png',
//                         fit: BoxFit.contain,
//                       ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         course.title,
//                         style:
//                             Theme.of(context).textTheme.titleMedium,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     InkWell(
//                       onTap:
//                           () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder:
//                                   (context) => TrainerChatsPage(
//                                     trainerId: trainerId,
//                                   ),
//                             ),
//                           ),
//                       borderRadius: BorderRadius.circular(10),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.indigo.shade50,
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             color: Colors.indigo.shade100,
//                           ),
//                         ),
//                         child: Row(
//                           children: const [
//                             Icon(
//                               Icons.chat,
//                               color: Colors.indigo,
//                               size: 18,
//                             ),
//                             SizedBox(width: 6),
//                             Text(
//                               "chats",
//                               style: TextStyle(color: Colors.indigo),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   '${course.enrolledStudents.length} • "updated 90 days"',
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//                 const SizedBox(height: 12),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: LinearProgressIndicator(
//                     value: 7,
//                     backgroundColor: Colors.grey.shade300,
//                     color: Colors.indigo,
//                     minHeight: 6,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     OutlinedButton.icon(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) => CourseDetailsForCenter(
//                                   course: course,
//                                   isForTrainer: true,
//                                 ),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.settings_outlined),
//                       label: const Text('Manage Course'),
//                       style: OutlinedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF1F3F9),
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: const Color(0xFFE5E7EB),
//                         ),
//                       ),
//                       child: const Text(
//                         'Details',
//                         style: TextStyle(color: Colors.black87),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// /*
// import 'package:flutter/material.dart';

// class TrainerDashboard extends StatelessWidget {
//   const TrainerDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Trainer Dashboard'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Welcome, Trainer 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 16),

//             /// Horizontal stats row wrapped in scroll view to avoid overflow
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   _buildStatCard('Centers', '5', Icons.location_city),
//                   const SizedBox(width: 16),
//                   _buildStatCard('Courses', '12', Icons.menu_book),
//                   const SizedBox(width: 16),
//                   _buildStatCard('Students', '120', Icons.group),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),

//             const Text('My Courses', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             _buildCourseCard(
//               title: 'Flutter for Beginners',
//               students: 30,
//               date: 'May 10, 2025',
//             ),
//             _buildCourseCard(
//               title: 'Advanced Dart',
//               students: 18,
//               date: 'May 12, 2025',
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard(String title, String count, IconData icon) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 3,
//       child: Container(
//         width: 160,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Icon(icon, size: 40, color: Colors.blue),
//             const SizedBox(height: 12),
//             Text(count, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 4),
//             Text(title, style: const TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCourseCard({required String title, required int students, required String date}) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         leading: const Icon(Icons.book, size: 40, color: Colors.deepPurple),
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
//         subtitle: Text('$students Students\nStarts: $date'),
//         isThreeLine: true,
//         trailing: const Icon(Icons.arrow_forward_ios),
//       ),
//     );
//   }
// }


//  */