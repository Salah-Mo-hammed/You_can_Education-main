// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grad_project_ver_1/features/chat/domain/entities/message_entity.dart';
// import 'package:grad_project_ver_1/features/chat/presintation/bloc/chat_bloc.dart';

// class ChatChannelPage extends StatelessWidget {
//   final String studentName;
//   final String trainerId;
//   final String chatRoomId;

//   ChatChannelPage({
//     required this.studentName,
//     required this.trainerId,
//     required this.chatRoomId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(studentName),
//         backgroundColor: Colors.teal,
//       ),
//       body: BlocBuilder<ChatBloc, ChatState>(
//           builder: (context, state) {
//             if (state is ChatLoading) {
//               return Center(child: CircularProgressIndicator());
//             }

//             if (state is ChatLoaded) {
//               final messagesStream = state.messagesStream;
//               return StreamBuilder<List<MessageEntity>>(
//                 stream: messagesStream,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }

//                   if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   }

//                   if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(child: Text('No messages yet.'));
//                   }

//                   final messages = snapshot.data!;
//                   return ListView.builder(
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       return ListTile(
//                         title: Text(message.text),
//                         subtitle: Text(message.createdAt.toString()), // Display time or other details
//                       );
//                     },
//                   );
//                 },
//               );
//             }

//             if (state is ChatError) {
//               return Center(child: Text('Error: ${state.message}'));
//             }

//             return Center(child: Text('No messages yet.'));
//           },
//         ),
//       );
    
//   }
// }
