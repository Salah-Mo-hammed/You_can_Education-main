import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/features/auth/presintation/widgets/auth_widget.dart';

class UserTypeSelectionPage extends StatefulWidget {
  const UserTypeSelectionPage({super.key});

  @override
  State<UserTypeSelectionPage> createState() =>
      _UserTypeSelectionPageState();
}

class _UserTypeSelectionPageState
    extends State<UserTypeSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image (same as AuthWidget)
          Positioned.fill(
            child: FadeIn(
              delay: Duration(microseconds: 1),
              child: Image.asset(
                'assets/images/auth_background.png', // Match with login
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
                      "Choose Your Role",
                      35,
                      Colors.white,
                      FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInUp(
                    delay: const Duration(milliseconds: 1900),
                    child: Text(
                      "Select how you want to join our learning community",
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
                          Row(
                            children: [
                              _buildRoleCard(
                                context,
                                "Student",
                                Icons.people,
                                "Access courses & start learning",
                                2100,
                                () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      opaque: false,
                                      transitionDuration: Duration(
                                        milliseconds: 400,
                                      ),
                                      pageBuilder:
                                          (_, __, ___) =>
                                              const AuthWidget(
                                                doRegister: true,
                                                role: 'student',
                                              ),
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
                                  );
                                },
                              ),
                              const SizedBox(width: 12),
                              _buildRoleCard(
                                context,
                                "Center",
                                Icons.menu_book_sharp,
                                "Make courses & Share knowledge",
                                2300,
                                () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      opaque: false,
                                      transitionDuration: Duration(
                                        milliseconds: 400,
                                      ),
                                      pageBuilder:
                                          (_, __, ___) =>
                                              const AuthWidget(
                                                doRegister: true,
                                                role: 'center',
                                              ),
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
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          FadeInUp(
                            delay: const Duration(milliseconds: 2500),
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
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
      textAlign: TextAlign.center,
    );
  }

  Expanded _buildRoleCard(
    BuildContext context,
    String title,
    IconData icon,
    String description,
    int milliseconds,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: FadeInUp(
        delay: Duration(milliseconds: milliseconds),
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(
                  //   0.2,
                  // ), // translucent card
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    width: 3,
                    color: Color.fromARGB(
                      255,
                      139,
                      102,
                      158,
                    ).withOpacity(0.4),
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: AppColors.gold.withOpacity(0.25),
                  //     blurRadius: 12,
                  //     offset: const Offset(0, 6),
                  //   ),
                  // ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.85),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
              Positioned(
                top: -25,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 30,
                      color: Color(0xFF571874),
                      // new new purple
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
