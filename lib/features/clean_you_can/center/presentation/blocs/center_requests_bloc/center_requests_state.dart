part of 'center_requests_bloc.dart';

sealed class CenterRequestsState {
  const CenterRequestsState();
}

class CenterRequestsInitial extends CenterRequestsState {}

class CenterRequestsLoadingState extends CenterRequestsState {}

class CenterRequestsDoneState extends CenterRequestsState {
  List<Map<String, dynamic>> requests;
  CenterRequestsDoneState({required this.requests});
}

class CenterRequestsExceptionState extends CenterRequestsState {
  String message;
  CenterRequestsExceptionState({required this.message});
}

