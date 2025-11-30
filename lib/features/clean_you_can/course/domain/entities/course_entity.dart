class CourseEntity {
  final String courseId;
  final String trainerId;
  final String title;
  final String description;
  final String? imageUrl;
  final String centerId;
  final int maxStudents;
  final double price;
  Set<String> enrolledStudents;
  List<String> topics;
  Map<String,dynamic> urls;
  final DateTime startDate;
  final DateTime endDate;
  CourseEntity({
    required this.courseId,
    required this.trainerId,
    required this.title,
    required this.description,
    required this.centerId,
    required this.startDate,
    required this.endDate,
    required this.maxStudents,
    required this.price,
    this.imageUrl,
    this.enrolledStudents = const {},
    this.topics = const [],
    this.urls=const {}
  });
}
