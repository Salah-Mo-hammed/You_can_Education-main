part of 'center_requests_bloc.dart';

sealed class CenterRequestsEvent  {
  const CenterRequestsEvent();
}
class GetCenterRequestsEvent extends CenterRequestsEvent{
  String centerId;
  GetCenterRequestsEvent({required this.centerId});
} 
class ApproveJoinRequestEvent extends CenterRequestsEvent{
  Map<String,dynamic> requestMap;
  ApproveJoinRequestEvent({required this.requestMap});
}
class CenterLogOutRequestsPartEvent extends CenterRequestsEvent {
  CenterLogOutRequestsPartEvent();
}