import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grad_project_ver_1/features/chat/presintation/bloc/chat_bloc.dart';
import 'package:grad_project_ver_1/features/chat/presintation/pages/chat_page.dart';

class TrainerChatsPage extends StatefulWidget {
  final String trainerId;

  TrainerChatsPage({required this.trainerId});

  @override
  State<TrainerChatsPage> createState() => _TrainerChatsPageState();
}

class _TrainerChatsPageState extends State<TrainerChatsPage> {
  @override
  void initState() {
    context.read<ChatBloc>().add(
      GetTrainerChatRoomsEvent(trianerId: widget.trainerId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Stack(
        children: [
          Positioned.fill(
            child: FadeIn(
              delay: const Duration(milliseconds: 500),
              child: Image.asset(
                "assets/images/trainer_background.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Text(
                      "Message",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return Center(child: Center(
            child: SpinKitFadingCube(
              color: Colors.white,
              size: 50.0,
            ),
          ),);
                    }

                    if (state is ChatRoomsLoaded) {
                      final chatRooms = state.chatRooms;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: buildSearchField(
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: chatRooms.length,
                              itemBuilder: (context, index) {
                                final chatRoom = chatRooms[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color(
                                      0xFFC39BD3,
                                    ),
                                    child: Icon(
                                      size: 30,
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(
                                    ' ${chatRoom.studentName}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Last message preview...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ), // Display last message preview here
                                  trailing: Text(
                                    '12:30 PM',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ), // Display last message time here
                                  onTap: () {
                                    // Navigate to the chat channel
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ChatPage(
                                              studentId:
                                                  chatRoom.studentId,
                                              trainerId:
                                                  chatRoom.trainerId,
                                              currentUserId:
                                                  chatRoom.trainerId,
                                              studentName:
                                                  chatRoom
                                                      .studentName,
                                              trainerName:
                                                  chatRoom
                                                      .trainerName,
                                            ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    if (state is ChatError) {
                      return Center(
                        child: Text('Error: ${state.message}'),
                      );
                    }

                    return Center(
                      child: Text(
                        'No chat rooms available.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSearchField({
    String hintText = 'Search...',
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[200]!.withOpacity(0.8),
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
