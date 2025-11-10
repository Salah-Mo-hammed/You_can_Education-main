class MessageEntity {
  final String id;
  final String senderId;
  final String recieverId;

  final String text;
  final DateTime createdAt;
  MessageEntity({
    required this.id,
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.createdAt,
  });
}
