import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/chat_room_entity.dart';

class ChatRoomModel extends ChatRoomEntity {
  ChatRoomModel({
    required String id,
    required String studentId,
    required String trainerId,
    required String studentName,
    required String trainerName,

    required DateTime createdAt,
  }) : super(
         id: id,
         studentId: studentId,
         trainerId: trainerId,
         studentName: studentName,
         trainerName: trainerName,
         createdAt: createdAt,
       );

  factory ChatRoomModel.fromMap(Map<String, dynamic> map, String id) {
    return ChatRoomModel(
      id: id,
      studentId: map['studentId'],
      trainerId: map['trainerId'],
      studentName: map['studentName'],
      trainerName: map['trainerName'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'trainerId': trainerId,
      'studentName': studentName,
      'trainerName': trainerName,
      'createdAt': createdAt,
    };
  }

  ChatRoomModel copyWith({
    String? id,
    String? studentId,
    String? trainerId,
    String? studentName,
    String? trainerName,
    DateTime? createdAt,
  }) {
    return ChatRoomModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      trainerId: trainerId ?? this.trainerId,
      studentName: studentName ?? this.studentName,
      trainerName: trainerName ?? this.trainerName,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
