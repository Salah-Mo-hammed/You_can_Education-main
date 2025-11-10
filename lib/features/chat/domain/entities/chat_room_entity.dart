class ChatRoomEntity {
  final String id;
  final String studentId;
  final String trainerId;
  final String studentName;
  final String trainerName;
  final DateTime createdAt;

  ChatRoomEntity({
    required this.id,
    required this.studentId,
    required this.trainerId,
    required this.studentName,
    required this.trainerName,
    required this.createdAt,
  });
}