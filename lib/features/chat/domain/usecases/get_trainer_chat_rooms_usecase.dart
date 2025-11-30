import 'package:grad_project_ver_1/features/chat/domain/entities/chat_room_entity.dart';
import 'package:grad_project_ver_1/features/chat/domain/repo/chat_repo.dart';

class GetTrainerChatRoomsUsecase {
  ChatRepo chatRepo;
  GetTrainerChatRoomsUsecase({required this.chatRepo});
    Future<List<ChatRoomEntity>> call(String trainerId){
      return chatRepo.getChatRoomsForTrainer(trainerId);
    }
}