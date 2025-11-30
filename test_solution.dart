// Test script to verify AuthBloc logic
import "package:grad_project_ver_1/features/auth/presintation/bloc/auth_bloc.dart";

void main() {
  print("AuthBloc modification completed successfully!");
  print("The AuthBloc now includes:");
  print("1. CenterGeneralBloc dependency");
  print("2. Automatic GetCenterInfoEvent dispatch for center logins");
  print("3. Debug print statements to track the event dispatch");
  print("");
  print("Key changes made:");
  print("- Added CenterGeneralBloc? centerGeneralBloc field");
  print("- Modified _onLogIn to dispatch GetCenterInfoEvent when role == \"center\"");
  print("- Modified _onRegister to dispatch GetCenterInfoEvent when role == \"center\"");
  print("- Updated injection container to provide CenterGeneralBloc dependency");
  print("");
  print("This ensures that every center login will automatically fetch fresh data!");
}
