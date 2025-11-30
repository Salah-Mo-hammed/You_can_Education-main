import 'package:grad_project_ver_1/features/chat/data/model/message_model.dart';
import 'package:grad_project_ver_1/features/chat/data/source/chat_remote_data_souce.dart';
import 'package:grad_project_ver_1/features/chat/domain/entities/chat_room_entity.dart';
import 'package:grad_project_ver_1/features/chat/domain/entities/message_entity.dart';
import 'package:grad_project_ver_1/features/chat/domain/repo/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatRemoteDataSource chatRemoteDataSource;
  ChatRepoImpl({required this.chatRemoteDataSource});

  @override
  Future<ChatRoomEntity> getOrCreateChat({
    required String studentId,
    required String trainerId,
    required String studentName,
    required String trainerName ,
  }) {
    return chatRemoteDataSource.getOrCreateChatRoom(
      studentId: studentId,
      trainerId: trainerId,
       studentName: studentName,
        trainerName: trainerName,
        
    );
  }

  @override
  Future<void> sendMessage({
    required String roomId,
    required MessageEntity message,
  }) {
    MessageModel messageModel = MessageModel(
      id: message.id,
      senderId: message.senderId,
      recieverId: message.recieverId,
      text: message.text,
      createdAt: message.createdAt,
    );
    return chatRemoteDataSource.sendMessage(
      roomId: roomId,
      message: messageModel,
    );
  }

  @override
  Stream<List<MessageEntity>> streamMessage(String roomId) {
    return chatRemoteDataSource.streamMessages(roomId);
  }
  
  @override
  Future<List<ChatRoomEntity>> getChatRoomsForTrainer(String trainerId) {
    return chatRemoteDataSource.getChatRoomsForTrainer(trainerId);
  }
}
