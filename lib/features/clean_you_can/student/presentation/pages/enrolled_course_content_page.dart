// import 'package:flutter/material.dart';

// class EnrolledCourseContentPage extends StatelessWidget {
//   final List<CourseContent> courseContents = [
//     CourseContent(
//       name: "Introduction to Flutter",
//       date: "2023-10-01",
//       url: "https://example.com/flutter-intro",
//     ),
//     CourseContent(
//       name: "State Management in Flutter",
//       date: "2023-10-05",
//       url: "https://example.com/state-management",
//     ),
//     CourseContent(
//       name: "Building Responsive UI",
//       date: "2023-10-10",
//       url: "https://example.com/responsive-ui",
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Enrolled Course Content'),
//       ),
//       body: ListView.builder(
//         itemCount: courseContents.length,
//         itemBuilder: (context, index) {
//           final content = courseContents[index];
//           return Card(
//             margin: EdgeInsets.all(8.0),
//             child: ListTile(
//               title: Text(content.name),
//               subtitle: Text('Date: ${content.date}'),
//               trailing: Icon(Icons.link),
//               onTap: () {
//                 _openUrl(context, content.url);
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _openUrl(BuildContext context, String url) {
//     // You can use a package like url_launcher to open the URL
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Opening URL: $url')),
//     );
//   }
// }

// class CourseContent {
//   final String name;
//   final String date;
//   final String url;

//   CourseContent({
//     required this.name,
//     required this.date,
//     required this.url,
//   });
// }