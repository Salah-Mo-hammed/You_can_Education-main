part of 'center_general_bloc.dart';

sealed class CenterGeneralState  {
  const CenterGeneralState();
 
}

 class CenterGeneralInitial extends CenterGeneralState {}
 class CenterGeneralLoadingState extends CenterGeneralState {}


class CenterGeneralCreatedState extends CenterGeneralState {}

class CenterGeneralUpdatedInfoState extends CenterGeneralState {}

class CenterGeneralGotInfoState extends CenterGeneralState {
  CenterEntity centerInfo;
  CenterGeneralGotInfoState({required this.centerInfo});
}

class CenterGeneralExceptionState extends CenterGeneralState {
  final String message;
  CenterGeneralExceptionState({required this.message});
}
