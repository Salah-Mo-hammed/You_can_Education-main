part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final Stream<List<MessageEntity>> messagesStream;

  ChatLoaded({required this.messagesStream});

  @override
  List<Object?> get props => [messagesStream];
}

class ChatError extends ChatState {
  final String message;

  ChatError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChatRoomsLoaded extends ChatState {
  final List<ChatRoomEntity> chatRooms;
  ChatRoomsLoaded({required this.chatRooms});
  @override
  List<Object?> get props => [chatRooms];
}
