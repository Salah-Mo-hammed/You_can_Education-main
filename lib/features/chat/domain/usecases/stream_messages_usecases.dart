import 'package:grad_project_ver_1/features/chat/domain/entities/message_entity.dart';
import 'package:grad_project_ver_1/features/chat/domain/repo/chat_repo.dart';

class StreamMessagesUsecases {
  final ChatRepo chatRepo;
  StreamMessagesUsecases({required this.chatRepo});
  Stream<List<MessageEntity>> call(String roomId) {
    return chatRepo.streamMessage(roomId);
  }
}
