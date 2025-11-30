import 'package:grad_project_ver_1/features/chat/domain/entities/chat_room_entity.dart';
import 'package:grad_project_ver_1/features/chat/domain/repo/chat_repo.dart';

class GetOrCreateChatRoomUsecase {
  final ChatRepo chatRepo;
  GetOrCreateChatRoomUsecase({required this.chatRepo});
  Future<ChatRoomEntity> call({
    required String studentId,
    required String trainerId,
   required String studentName,
    required String trainerName ,
  }) {
    return chatRepo.getOrCreateChat(
      studentId: studentId,
      trainerId: trainerId,
      studentName: studentName,
      trainerName: trainerName,

    );
  }
}
