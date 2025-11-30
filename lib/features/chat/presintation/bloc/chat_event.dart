part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadChatRoomEvent extends ChatEvent {
  final String studentId;
  final String trainerId;
  final String studentName;
  final String trainerName;


  LoadChatRoomEvent({
    required this.studentId,
    required this.trainerId,
    required this.studentName,
    required this.trainerName,

  });

  @override
  List<Object?> get props => [studentId, trainerId, /*courseId*/];
}

class SendMessageEvent extends ChatEvent {
  final MessageEntity message;

  SendMessageEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class StartListeningToMessages extends ChatEvent {
  final String roomId;

  StartListeningToMessages({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}

class GetTrainerChatRoomsEvent extends ChatEvent{
  final String trianerId;
  GetTrainerChatRoomsEvent({required this.trianerId});
}