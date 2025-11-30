import 'package:grad_project_ver_1/features/chat/domain/entities/message_entity.dart';
import 'package:grad_project_ver_1/features/chat/domain/repo/chat_repo.dart';

class SendMessageUsecase {
  final ChatRepo chatRepo;
  SendMessageUsecase({required this.chatRepo});
  Future<void> call({
    required String roomId,
    required MessageEntity message,
  }) {
    return chatRepo.sendMessage(roomId: roomId, message: message);
  }
}
