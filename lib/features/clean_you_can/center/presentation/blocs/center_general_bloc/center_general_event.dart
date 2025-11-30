part of 'center_general_bloc.dart';

sealed class CenterGeneralEvent {
  const CenterGeneralEvent();
}

class CreateCenterEvent extends CenterGeneralEvent {
  CenterEntity createCenter;
  CreateCenterEvent({required this.createCenter});
}
class UpdateCenterInfoEvent extends CenterGeneralEvent {
  CenterEntity updatedCenter;
  UpdateCenterInfoEvent({required this.updatedCenter});
}
class ResetCenterEvent extends CenterGeneralEvent {}

class GetCenterInfoEvent extends CenterGeneralEvent{
  String centerId;
  GetCenterInfoEvent({required this.centerId});
}
class CenterLogOutGeneralPartEvent extends CenterGeneralEvent {
  CenterLogOutGeneralPartEvent();
}