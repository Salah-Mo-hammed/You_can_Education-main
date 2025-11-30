import 'package:grad_project_ver_1/features/chat/domain/entities/chat_room_entity.dart';
import 'package:grad_project_ver_1/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepo {
  // create or get the chat room between the student and the trainer for the course
  Future<ChatRoomEntity> getOrCreateChat({
    required String studentId,
    required String trainerId,
    required String studentName,
    required String trainerName,
  });
  // send message inside the chat room
  Future<void> sendMessage({
    required String roomId,
    required MessageEntity message,
  });
  // Listene for the messages for this room instintly
  Stream<List<MessageEntity>> streamMessage(String roomId);
// this ti get the caht rooms for the trainer (trainer has many rooms , room fro each student)
  Future<List<ChatRoomEntity>> getChatRoomsForTrainer(String trainerId);

}
