import 'package:grad_project_ver_1/features/auth/domain/repo/auth_repo.dart';

class GetAuthStatusUseCase {
  AuthRepo repo;
  GetAuthStatusUseCase({required this.repo});
  Future< bool> call() {
    return repo.isLoggedIn();
  }
}
