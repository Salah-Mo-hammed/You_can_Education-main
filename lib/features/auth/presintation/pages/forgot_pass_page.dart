import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_event.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_state.dart';
import 'package:grad_project_ver_1/features/auth/presintation/widgets/auth_widget.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController emailController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: FadeIn(
              delay: const Duration(milliseconds: 1),
              child: Image.asset(
                'assets/images/auth_background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          FadeIn(
            delay: const Duration(milliseconds: 1500),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  FadeInUp(
                    delay: const Duration(milliseconds: 1700),
                    child: _buildText(
                      "Reset Password",
                      35,
                      Colors.white,
                      FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInUp(
                    delay: const Duration(milliseconds: 1900),
                    child: Text(
                      "Enter your email address to receive a reset link",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(
                                  255,
                                  139,
                                  102,
                                  158,
                                ).withOpacity(0.6),
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildEmailField(),
                                const SizedBox(height: 25),
                                BlocConsumer<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthStateException) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            state.exceptionMessage ??
                                                "An error occurred",
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else if (state
                                        is AuthStateSuccessReset) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Password reset email sent successfully.",
                                          ),
                                          backgroundColor:
                                              Colors.green,
                                        ),
                                      );
                                      Future.delayed(
                                        const Duration(seconds: 2),
                                        () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      AuthWidget(
                                                        doRegister:
                                                            false,
                                                      ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return state is AuthStateLoading
                                        ? Center(
                                          child: SpinKitFadingCube(
                                            color: Colors.white,
                                            size: 50.0,
                                          ),
                                        )
                                        : InkWell(
                                          onTap: () {
                                            final email =
                                                emailController.text
                                                    .trim();
                                            if (email.isNotEmpty) {
                                              context
                                                  .read<AuthBloc>()
                                                  .add(
                                                    AuthResetPassEvent(
                                                      email: email,
                                                    ),
                                                  );
                                            }
                                          },
                                          borderRadius:
                                              BorderRadius.circular(
                                                12,
                                              ),
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                  vertical: 14,
                                                ),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(
                                                0xFFC39BD3,
                                              ),

                                              borderRadius:
                                                  BorderRadius.circular(
                                                    25,
                                                  ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Reset Password",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 50,
                              ),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  50,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Go Back",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Icon(Icons.email_outlined, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email Address",
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _buildText(
    String text,
    double size,
    Color color,
    FontWeight weight,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
    );
  }
}
