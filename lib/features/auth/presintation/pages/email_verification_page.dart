// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project_ver_1/core/common/continue_info.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/presintation/pages/trainer_dashboard.dart';

// ignore: must_be_immutable
class EmailVerificationPage extends StatefulWidget {
  String role;
  EmailVerificationPage({super.key, required this.role});

  @override
  State<EmailVerificationPage> createState() =>
      _EmailVerificationPageState();
}

class _EmailVerificationPageState
    extends State<EmailVerificationPage> {
  bool isVerified = false;
  bool showAnimation = false; // triggers icon animation
  Timer? _timer;

  // Firebase email verification check
  void _startEmailCheck() {
    _timer = Timer.periodic(const Duration(seconds: 20), (
      timer,
    ) async {
      try {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user != null && user.emailVerified) {
          setState(() {
            isVerified = true;
            showAnimation = true; // trigger animation
          });
          timer.cancel();
        }
      } catch (e) {
        print('Email check failed: $e');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startEmailCheck();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _navigateToDashboard() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (widget.role == "Trainer") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    TrainerDashboardPage(trainerId: user.uid),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => ContinueInfo(
                  role: widget.role,
                  userId: user.uid,
                  email: user.email.toString(),
                ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: FadeIn(
              delay: const Duration(milliseconds: 500),
              child: Image.asset(
                "assets/images/auth_background.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Animated icon row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Email icon (always)
                    const Icon(
                      Icons.email_outlined,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),

                    // Animated arrow → success
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 800),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child:
                          showAnimation
                              ? Stack(
                                key: const ValueKey('success'),
                                alignment: Alignment.center,
                                children: [
                                  const Icon(
                                    Icons.task_alt_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ],
                              )
                              : const Icon(
                                Icons.arrow_right_alt,
                                key: ValueKey('arrow'),
                                size: 80,
                                color: Colors.white,
                              ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Instructions text
                const Text(
                  "We have sent a verification link to your email.\nPlease confirm to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 20),

                // Waiting text or OK button
                isVerified
                    ? ElevatedButton(
                      onPressed: _navigateToDashboard,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 14,
                        ),
                      ),
                      child: const Text(
                        "OK",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 139, 102, 158),
                        ),
                      ),
                    )
                    : const Text(
                      "waiting for verification",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Optional: Sun rays painter for success icon
class SunRaysPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const raysCount = 12;

    for (int i = 0; i < raysCount; i++) {
      final angle = (i * 2 * 3.1416 / raysCount);
      final start = Offset(
        center.dx + radius * 0.6 * cos(angle),
        center.dy + radius * 0.6 * sin(angle),
      );
      final end = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}