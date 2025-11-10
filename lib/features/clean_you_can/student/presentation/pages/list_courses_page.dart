// import 'package:flutter/material.dart';

// class ListCoursesPage extends StatelessWidget {
//   final List<Map<String, String>> fakeCourses = [
//     {'title': 'Flutter Basics', 'description': 'Learn the basics of Flutter'},
//     {'title': 'Advanced Dart', 'description': 'Master the Dart programming language'},
//     {'title': 'State Management', 'description': 'Explore BLoC, Provider, and GetX'},
//   ];

//    ListCoursesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Courses'),
//       ),
//       body: ListView.builder(
//         itemCount: fakeCourses.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: EdgeInsets.all(10),
//             child: ListTile(
//               title: Text(fakeCourses[index]['title']!),
//               subtitle: Text(fakeCourses[index]['description']!),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
