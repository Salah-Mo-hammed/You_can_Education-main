// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart' show InMemoryChatController;
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:grad_project_ver_1/features/chat/domain/entities/message_entity.dart';
// import 'package:grad_project_ver_1/features/chat/presintation/bloc/chat_bloc.dart';
// import 'package:uuid/uuid.dart';


// class ChatPage extends StatefulWidget {
//   final String studentId;
//   final String trainerId;
//   final String courseId;
//   final String currentUserId;

//   const ChatPage({
//     Key? key,
//     required this.studentId,
//     required this.trainerId,
//     required this.courseId,
//     required this.currentUserId,
//   }) : super(key: key);

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final _chatController = InMemoryChatController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<ChatBloc>().add(
//           LoadChatRoomEvent(
//             studentId: widget.studentId,
//             trainerId: widget.trainerId,
//             courseId: widget.courseId,
//           ),
//         );
//   }

//   @override
//   void dispose() {
//     _chatController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('الدردشة')),
//       body: BlocBuilder<ChatBloc, ChatState>(
//         builder: (context, state) {
//           if (state is ChatLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ChatLoaded) {
//             return StreamBuilder<List<MessageEntity>>(
//               stream: state.messagesStream,
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final messages = snapshot.data!
//                     .map((e) => types.TextMessage(
//                           id: e.id,
//                           author: types.User(id: e.senderId),
//                           createdAt: e.createdAt.millisecondsSinceEpoch,
//                           text: e.text,
//                         ))
//                     .toList();

//                 _chatController.loadMessages(messages);

//                 return Chat(
//                   chatController: _chatController,
//                   currentUserId: widget.currentUserId,
               
//                   onSendPressed: (partialText) {
//                     final newMessage = MessageEntity(
//                       id: const Uuid().v4(),
//                       text: partialText.text,
//                       senderId: widget.currentUserId,
//                       createdAt: DateTime.now(),
//                     );

//                     context.read<ChatBloc>().add(SendMessageEvent( message:newMessage));

//                     // Optimistic UI
//                     _chatController.insertMessage(types.TextMessage(
//                       id: newMessage.id,
//                       text: newMessage.text,
//                       createdAt: newMessage.createdAt.millisecondsSinceEpoch,
//                       author: types.User(id: newMessage.senderId),
//                     ));
//                   },
//                 );
//               },
//             );
//           } else if (state is ChatError) {
//             return Center(child: Text("خطأ: ${state.message}"));
//           } else {
//             return const Center(child: Text("حدث خطأ غير متوقع"));
//           }
//         },
//       ),
//     );
//   }
// }

// // import 'dart:math';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_chat_core/flutter_chat_core.dart';
// // import 'package:flutter_chat_ui/flutter_chat_ui.dart';

// // class Basic extends StatefulWidget {
// //   const Basic({super.key});

// //   @override
// //   BasicState createState() => BasicState();
// // }

// // class BasicState extends State<Basic> {
// //   final _chatController = InMemoryChatController();

// //   @override
// //   void dispose() {
// //     _chatController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("chat page"),
// //       ),
// //       body: Chat(
// //         chatController: _chatController,
// //         currentUserId: 'user1',
// //         onMessageSend: (text) {
// //           _chatController.insertMessage(
// //             TextMessage(
// //               // Better to use UUID or similar for the ID - IDs must be unique
// //               id: '${Random().nextInt(1000) + 1}',
// //               authorId: 'user1',
// //               createdAt: DateTime.now().toUtc(),
// //               text: text,
// //             ),
// //           );
// //         },
// //         resolveUser: (UserID id) async {
// //           return User(id: id, name: 'John Doe');
// //         },
// //       ),
// //     );
// //   }
// // }