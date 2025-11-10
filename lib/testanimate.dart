import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SunSuccessAnimationPage extends StatefulWidget {
  const SunSuccessAnimationPage({super.key});

  @override
  State<SunSuccessAnimationPage> createState() =>
      _SunSuccessAnimationPageState();
}

class _SunSuccessAnimationPageState extends State<SunSuccessAnimationPage>
    with TickerProviderStateMixin {
  bool isVerified = false;

  late AnimationController _pulseController;
  late AnimationController _raysController;

  @override
  void initState() {
    super.initState();

    // Pulse animation for email icon
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);

    // Animation controller for sun rays
    _raysController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Simulate email verification after 5 seconds
    Timer(const Duration(seconds: 5), () {
      _pulseController.stop();
      setState(() {
        isVerified = true;
      });
      _raysController.repeat();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _raysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutBack,
                  ),
                  child: child,
                );
              },
              child: isVerified
                  ? Stack(
                      key: const ValueKey('sun-success'),
                      alignment: Alignment.center,
                      children: [
                        // Rays around the checkmark
                        AnimatedBuilder(
                          animation: _raysController,
                          builder: (_, __) {
                            return Transform.rotate(
                              angle: _raysController.value * 6.28, // full rotation
                              child: CustomPaint(
                                size: const Size(150, 150),
                                painter: SunRaysPainter(),
                              ),
                            );
                          },
                        ),
                        const Icon(
                          Icons.check_circle,
                          size: 100,
                          color: Colors.yellowAccent,
                        ),
                      ],
                    )
                  : ScaleTransition(
                      scale: _pulseController,
                      child: const Icon(
                        Icons.email,
                        key: ValueKey('email'),
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
            ),
            const SizedBox(height: 30),
            Text(
              isVerified
                  ? "Email Verified!"
                  : "We have sent a verification link to your email.\nPlease confirm to continue.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter to draw sun rays
class SunRaysPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellowAccent.withOpacity(0.7)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    const raysCount = 12;
    for (int i = 0; i < raysCount; i++) {
      final angle = (i * 6.28 / raysCount);
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
