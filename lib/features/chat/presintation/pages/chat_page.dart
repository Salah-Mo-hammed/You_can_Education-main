import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grad_project_ver_1/features/chat/domain/entities/message_entity.dart';
import 'package:grad_project_ver_1/features/chat/presintation/bloc/chat_bloc.dart';

class ChatPage extends StatefulWidget {
  final String studentId;
  final String trainerId;
  final String currentUserId;
  final String studentName;
  final String trainerName;

  const ChatPage({
    Key? key,
    required this.studentId,
    required this.trainerId,
    required this.currentUserId,
    required this.studentName,
    required this.trainerName,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatUser chatUser;

  @override
  void initState() {
    super.initState();
    chatUser = ChatUser(
      id: widget.currentUserId,
      firstName:
          widget.currentUserId == widget.studentId
              ? widget.studentName
              : widget.trainerName,
    );

    context.read<ChatBloc>().add(
      LoadChatRoomEvent(
        studentId: widget.studentId,
        trainerId: widget.trainerId,
        studentName: widget.studentName,
        trainerName: widget.trainerName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // remove default back
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: FadeIn(
              delay: const Duration(milliseconds: 300),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.asset(
                  "assets/images/trainer_background.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoading) {
                return const Center(
                  child: Center(
                    child: Center(
                      child: SpinKitFadingCube(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ),
                );
              } else if (state is ChatLoaded) {
                return StreamBuilder<List<MessageEntity>>(
                  stream: state.messagesStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Center(
                          child: Center(
                            child: SpinKitFadingCube(
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                      );
                    }

                    final messages =
                        snapshot.data!
                            .map(
                              (msg) => ChatMessage(
                                text: msg.text,
                                createdAt: msg.createdAt,
                                user: ChatUser(id: msg.senderId),
                              ),
                            )
                            .toList()
                          ..sort(
                            (a, b) =>
                                b.createdAt.compareTo(a.createdAt),
                          );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed:
                                    () => Navigator.pop(context),
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white24,
                                child: Icon(
                                  Icons.person_2_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget
                                          .studentName, // or widget.trainerName depending on context
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.circle,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "Online",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: DashChat(
                            currentUser: chatUser,
                            messages: messages,
                            messageOptions: MessageOptions(
                              // currentUserContainerColor: Color(
                              //   0xFFF2F2F2,
                              // ).withOpacity(0.8),
                              // containerColor: Color(
                              //   0xFFF2F2F2,
                              // ).withOpacity(0.8),
                              messagePadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 25,
                              ),
                              borderRadius: 18,
                              messageDecorationBuilder: (
                                message,
                                previousMessage,
                                nextMessage,
                              ) {
                                if (message.user.id == chatUser.id) {
                                  // Sender bubble
                                  return BoxDecoration(
                                    color: Color(
                                      0xFFF2F2F2,
                                    ).withOpacity(0.8),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                      bottomLeft: Radius.circular(18),
                                      bottomRight: Radius.circular(
                                        5,
                                      ), // “tail”
                                    ),
                                  );
                                } else {
                                  // Receiver bubble
                                  return BoxDecoration(
                                    color: Color(
                                      0xFFF2F2F2,
                                    ).withOpacity(0.8),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(
                                        20,
                                      ),
                                    ), // fully rounded
                                  );
                                }
                              },
                              currentUserTextColor: Color(0xFF571874),
                              textColor: Color(0xFF571874),
                            ),
                            inputOptions: InputOptions(
                              sendButtonBuilder: (VoidCallback send) {
                                return IconButton(
                                  onPressed: send,
                                  icon: const Icon(
                                    Icons.send_outlined,
                                  ),
                                  color: Colors.white, // custom color
                                  iconSize: 28,
                                );
                              },
                              inputDecoration: InputDecoration(
                                hintText: "Type your message...",
                                hintStyle: TextStyle(
                                  color: Color(
                                    0xFF571874,
                                  ).withOpacity(0.55),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              alwaysShowSend:
                                  true, // show send icon even if input is empty
                            ),
                            onSend: (ChatMessage message) {
                              final entity = MessageEntity(
                                id: '',
                                text: message.text,
                                senderId: widget.currentUserId,
                                recieverId:
                                    widget.currentUserId ==
                                            widget.studentId
                                        ? widget.trainerId
                                        : widget.studentId,
                                createdAt: DateTime.now(),
                              );
                              context.read<ChatBloc>().add(
                                SendMessageEvent(message: entity),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (state is ChatError) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    'No chat data',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
