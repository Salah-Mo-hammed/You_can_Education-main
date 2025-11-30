
sealed class TrainerEvent  {
  const TrainerEvent();
}
class getTraienrCoursesEvent extends TrainerEvent{
  final String trainerId;
  getTraienrCoursesEvent({required this.trainerId});
}

class getTraienrInfoEvent extends TrainerEvent{
  final String trainerId;
  getTraienrInfoEvent({required this.trainerId});
}

