import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/core/common/continue_info.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_event.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_state.dart';
import 'package:grad_project_ver_1/features/auth/presintation/pages/email_verification_page.dart';
import 'package:grad_project_ver_1/features/auth/presintation/pages/forgot_pass_page.dart';
import 'package:grad_project_ver_1/features/auth/presintation/pages/user_type_selection.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_dashboard_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/student_dashboard.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/pages/trainer_dashboard.dart';

class AuthWidget extends StatefulWidget {
  final bool doRegister;
  final String? role;
  const AuthWidget({super.key, required this.doRegister, this.role});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();

  int failAttempt = 0;
  bool isLocked = false;
  int countdown = 5;

  // Lock button for 5 seconds after 3 failed attempts
  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown == 1) {
        setState(() {
          isLocked = false;
          failAttempt = 0;
          countdown = 5;
        });
        timer.cancel();
      } else {
        setState(() => countdown--);
      }
    });
  }

  // Handles authentication state changes from BlocConsumer listener
  void _handleAuthState(BuildContext context, AuthState state) async {
    if (state is Authenticated) {
      final userRole = state.authUser.role;

      if (state.authUser.isVerified) {
        if (userRole == "Trainer") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => TrainerDashboardPage(
                    trainerId: state.authUser.uid,
                  ),
            ),
          );
          return;
        }

        if (state.authUser.isCompletedInfo!) {
          if (userRole == "center") {
            // await NotificationService().initFirebaseMessaging(state.authUser.uid);
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (_) =>
                      userRole == "center"
                          ? CenterDashboard(
                            centerId: state.authUser.uid,
                          )
                          : StudentDashboard(
                            currentStudentId: state.authUser.uid,
                          ),
            ),
          );
          return;
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (_) => ContinueInfo(
                    role: state.authUser.role,
                    userId: state.authUser.uid,
                    email: state.authUser.email,
                  ),
            ),
          );
          return;
        }
      } else {
        if (userRole == "Trainer") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => TrainerDashboardPage(
                    trainerId: state.authUser.uid,
                  ),
            ),
          );
          return;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => EmailVerificationPage(role: userRole),
          ),
        );
        return;
      }
    } else if (state is AuthStateException) {
      print("Auth exception: ${state.exceptionMessage}");
      failAttempt++;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.exceptionMessage.toString())),
      );
      if (failAttempt >= 3) {
        setState(() => isLocked = true);
        startCountdown();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: _handleAuthState,
        builder: (context, state) {
          if (state is AuthStateLoading) {
            return const Center(
              child: Center(
                child: SpinKitFadingCube(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            );
          }
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/auth_background.png',
                  fit: BoxFit.cover,
                ),
              ),
              _authWidget(context),
            ],
          );
        },
      ),
    );
  }

  Widget _authWidget(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 100),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/auth_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(
                    delay: const Duration(milliseconds: 1700),
                    child: _buildText(
                      widget.doRegister ? "Register" : "Login",
                      35,
                      Colors.white,
                      FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  FadeInUp(
                    delay: Duration(milliseconds: 1900),
                    child: Text(
                      "You Can Do It",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      FadeInUp(
                        delay: const Duration(milliseconds: 2100),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(
                                255,
                                139,
                                102,
                                158,
                              ).withOpacity(0.4),
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              _buildRowTextFeild(
                                Icons.email_outlined,
                                "email",
                                emailController,
                                false,
                                Colors.white,
                                Colors.white,
                              ),
                              _buildRowTextFeild(
                                Icons.lock_outline_rounded,
                                "password",
                                passwordController,
                                true,
                                Colors.white,
                                Colors.white,
                              ),

                              const SizedBox(height: 5),
                              if (!widget.doRegister)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(" "),
                                    TextButton(
                                      onPressed:
                                          () => Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              opaque: false,
                                              transitionDuration:
                                                  const Duration(
                                                    milliseconds: 400,
                                                  ),
                                              pageBuilder:
                                                  (_, __, ___) =>
                                                      ForgotPasswordPage(),
                                              transitionsBuilder: (
                                                _,
                                                animation,
                                                __,
                                                child,
                                              ) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ),
                                          ),
                                      child: Text(
                                        "Forgot Password ?",
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration
                                                  .underline,
                                          decorationColor:
                                              Colors.white,
                                          decorationThickness: 1,
                                          color: AppColors.lightGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              Row(
                                children: [
                                  if (!widget.doRegister)
                                    _buildSocialActionButton(
                                      "Register",
                                      3200,
                                      AppColors.register,
                                      () => Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          opaque: false,
                                          transitionDuration:
                                              const Duration(
                                                milliseconds: 400,
                                              ),
                                          pageBuilder:
                                              (_, __, ___) =>
                                                  const UserTypeSelectionPage(),
                                          transitionsBuilder: (
                                            _,
                                            animation,
                                            __,
                                            child,
                                          ) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  if (!widget.doRegister)
                                    SizedBox(width: 15),
                                  Expanded(
                                    child: _buildActionButton(
                                      context,
                                    ),
                                  ),
                                ],
                              ),

                              if (widget.doRegister) ...[
                                SizedBox(height: 10),
                                FadeInUp(
                                  delay: Duration(milliseconds: 3200),
                                  child: InkWell(
                                    onTap:
                                        () => Navigator.pop(context),
                                    child: Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Go Back",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildSocialActionButton(
    String title,
    int milliseconds,
    Gradient gradient,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: FadeInUp(
        delay: Duration(milliseconds: milliseconds),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color.fromARGB(255, 195, 155, 211),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildRowTextFeild(
    IconData icon,
    String title,
    TextEditingController controller,
    bool isPassword,
    Color color,
    Color color2,
  ) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 5),
          Expanded(
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              obscureText: isPassword,
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text(title, style: TextStyle(color: color2)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _buildText(
    String title,
    double size,
    Color color,
    FontWeight weight,
  ) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return isLocked
        ? Column(
          children: [
            Text(
              "3 attempts failed, wait for $countdown seconds to log in",
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: null,
              child: Text("Retry in $countdown sec"),
            ),
          ],
        )
        : FadeInUp(
          delay: const Duration(milliseconds: 2300),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 195, 155, 211),
              borderRadius: BorderRadius.circular(25),
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                print(
                  "Logging in email: ${emailController.text.trim()}",
                );
                print(
                  "Logging in password: ${passwordController.text.trim()}",
                );

                if (!_validateInputs()) return;
                if (widget.doRegister) {
                  context.read<AuthBloc>().add(
                    AuthRegisterEvent(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      role: widget.role!,
                    ),
                  );
                } else {
                  context.read<AuthBloc>().add(
                    AuthLogInEvent(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    ),
                  );
                }
              },
              child: _buildText(
                widget.doRegister ? 'Register' : 'Log In',
                18,
                Colors.white,
                FontWeight.bold,
              ),
            ),
          ),
        );
  }

  bool _validateInputs() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || !email.contains("@")) {
      _showError("Please enter a valid email address.");
      return false;
    }
    if (password.isEmpty || password.length < 6) {
      _showError("Password must be at least 6 characters long.");
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
