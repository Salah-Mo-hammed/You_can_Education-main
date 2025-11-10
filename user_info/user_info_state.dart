part of 'user_info_bloc.dart';

sealed class UserInfoState extends Equatable {
  const UserInfoState();
  
  @override
  List<Object> get props => [];
}

final class UserInfoInitial extends UserInfoState {}
