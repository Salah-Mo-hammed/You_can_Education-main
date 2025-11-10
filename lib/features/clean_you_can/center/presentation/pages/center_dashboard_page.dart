// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/core/splash_page.dart';
import 'package:grad_project_ver_1/dependency_manager.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_courses_bloc/center_courses_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_general_bloc/center_general_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_requests_bloc/center_requests_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_state.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/add_course_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/add_trainer_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_course_details_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/edit_center_profil_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/widgets/fancy_bottom_van_bar.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';
import 'package:grad_project_ver_1/restart_widget.dart';

class CenterDashboard extends StatefulWidget {
  final String centerId;
  late List<TrainerEntity> availableTrainers;
  CenterDashboard({super.key, required this.centerId});

  @override
  _CenterDashboardState createState() => _CenterDashboardState();
}

class _CenterDashboardState extends State<CenterDashboard> {
  int _selectedIndex = 0;

  void _refreshDashboard() {
    final centerId = widget.centerId;

    // Dispatch bloc events again to reload all center data
    context.read<CenterCoursesBloc>().add(
      GetCenterCoursesEvent(centerId: widget.centerId),
    );
    context.read<CenterGeneralBloc>().add(
      GetCenterInfoEvent(centerId: widget.centerId),
    );
    context.read<CenterGeneralBloc>().add(
      GetCenterInfoEvent(centerId: widget.centerId),
    );
    context.read<CenterRequestsBloc>().add(
      GetCenterRequestsEvent(centerId: widget.centerId),
    );

    context.read<CenterTrainerBloc>().add(
      FetchCenterTrainers(centerId: widget.centerId),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Dashboard refreshed successfully!"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    //!get the center from the firestore
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔹 Background Image (covers whole screen)
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/center_dashboard_background_ver2.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // 🔹 Foreground (Scaffold on top of image)
        Scaffold(
          backgroundColor: Colors.transparent, // keep transparent
          // appBar: AppBar(
          //   title: FadeInDown(
          //     duration: const Duration(milliseconds: 700),
          //     child: const Text(
          //       "Center Dashboard",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //         fontSize: 35,
          //       ),
          //     ),
          //   ),
          //   centerTitle: true,
          //   elevation: 0,
          //   backgroundColor: Colors.transparent,
          //   iconTheme: const IconThemeData(color: AppColors.brown),

          //   actions: [
          //     IconButton(
          //       icon: const Icon(
          //         Icons.refresh,
          //         color: AppColors.bronze,
          //       ),
          //       onPressed: _refreshDashboard,
          //     ),
          //   ],
          // ),
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              _buildCoursesPage(),
              _buildJoinRequestsPage(),
              _buildTrainersPage(),
              _buildProfilePage(),
            ],
          ),

          bottomNavigationBar: FancyBottomNavBar(
            selectedIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
          floatingActionButton:
              _selectedIndex == 1 ||
                      _selectedIndex ==
                          2 || //add trainer floating back delete this (2)
                      _selectedIndex == 3
                  ? null
                  : FadeIn(
                    duration: const Duration(milliseconds: 420),
                    child: FloatingActionButton(
                      shape: CircleBorder(),
                      backgroundColor: const Color.fromARGB(
                        255,
                        139,
                        102,
                        158,
                      ),
                      elevation: 7,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    _selectedIndex == 0
                                        ? AddCoursePage(
                                          centerId: widget.centerId,
                                          availableTrainers:
                                              widget
                                                  .availableTrainers,
                                        )
                                        : AddTrainerPage(
                                          centerId: widget.centerId,
                                        ),
                          ),
                        );
                      },
                      child: Icon(
                        _selectedIndex == 0
                            ? Icons.add
                            : Icons.person_add_alt_1_outlined,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ],
    );
  }

  //! done Scaffold**********************************************************************
  Widget _buildCoursesPage() {
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 650),
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    SizedBox(height: 55),
                    const Text(
                      "Center Dashboard",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Your Courses",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      "Manage your courses efficiently!",
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(
                          255,
                          219,
                          217,
                          217,
                        ),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: BlocBuilder<
                CenterCoursesBloc,
                CenterCoursesState
              >(
                builder: (context, state) {
                  if (state is CenterGotCoursesState) {
                    if (state.courses.isEmpty) {
                      return Center(
                        child: FadeInUp(
                          child: Text(
                            "There are no courses yet.",
                            style: TextStyle(
                              color: Color.fromARGB(
                                255,
                                139,
                                102,
                                158,
                              ),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding:
                          EdgeInsets
                              .zero, // ✅ remove unwanted top spacing
                      separatorBuilder:
                          (_, __) => const SizedBox(height: 14),
                      itemCount: state.courses.length,
                      itemBuilder: (context, index) {
                        return TweenAnimationBuilder<double>(
                          duration: Duration(
                            milliseconds: 300 + index * 90,
                          ),
                          curve: Curves.easeOut,
                          tween: Tween(begin: 0, end: 1),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                20 * (1 - value),
                              ), // smooth upward slide
                              child: Opacity(
                                opacity: value,
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                255,
                                139,
                                102,
                                158,
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                    0.1,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(2, 4),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Left curved white strip
                                Positioned(
                                  left: 10,
                                  top: 0,
                                  bottom: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Container(
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            const BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(16),
                                              bottomLeft:
                                                  Radius.circular(16),
                                            ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withOpacity(0.25),
                                            blurRadius: 12,
                                            spreadRadius: 2,
                                            offset: const Offset(
                                              0,
                                              4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Card content
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    32,
                                    14,
                                    16,
                                    14,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 50,
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      state
                                                          .courses[index]
                                                          .title,
                                                      textAlign:
                                                          TextAlign
                                                              .center,
                                                      style: const TextStyle(
                                                        color:
                                                            Colors
                                                                .white,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        fontSize: 22,
                                                      ),
                                                      overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal:
                                                            10,
                                                        vertical: 4,
                                                      ),
                                                  decoration:
                                                      BoxDecoration(
                                                        color:
                                                            Colors
                                                                .white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              30,
                                                            ),
                                                      ),
                                                  child: Text(
                                                    "${state.courses[index].price}\$",
                                                    style: const TextStyle(
                                                      color: Color(
                                                        0xFF571874,
                                                      ),
                                                      fontWeight:
                                                          FontWeight
                                                              .bold,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                  ),
                                              child: Center(
                                                child: Text(
                                                  state
                                                      .courses[index]
                                                      .description,
                                                  textAlign:
                                                      TextAlign
                                                          .center,
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white
                                                        .withOpacity(
                                                          0.9,
                                                        ),
                                                    fontSize: 20,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is CenterCoursesExceptionState) {
                    return FadeIn(
                      duration: const Duration(milliseconds: 350),
                      child: Center(
                        child: Text(
                          state.message.toString(),
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else {
                    context.read<CenterCoursesBloc>().add(
                      GetCenterCoursesEvent(
                        centerId: widget.centerId,
                      ),
                    );
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePage() {
    return FadeIn(
      duration: const Duration(milliseconds: 520),
      child: BlocBuilder<CenterGeneralBloc, CenterGeneralState>(
        builder: (context, state) {
          if (state is CenterGeneralLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.deepPurple,
                ),
              ),
            );
          } else if (state is CenterGeneralGotInfoState) {
            final info = state.centerInfo;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                children: [
                  SizedBox(height: 55),
                  const Text(
                    "Center Dashboard",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(height: 80),
                  // Profile Card with more compact design
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Background circle
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                      0.08,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.deepPurple
                                    .withOpacity(0.2),
                                child: ClipOval(
                                  child:
                                      info.imageUrl == null
                                          ? Image.asset(
                                            'assets/images/grad_logo.png',
                                            width: 44,
                                            height: 44,
                                            fit: BoxFit.cover,
                                          )
                                          : Image.network(
                                            info.imageUrl!,
                                            width: 44,
                                            height: 44,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) => Image.asset(
                                                  'assets/images/grad_logo.png',
                                                  width: 84,
                                                  height: 84,
                                                  fit: BoxFit.cover,
                                                ),
                                            loadingBuilder: (
                                              context,
                                              child,
                                              loadingProgress,
                                            ) {
                                              if (loadingProgress ==
                                                  null)
                                                return child;
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value:
                                                      loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              (loadingProgress.expectedTotalBytes ??
                                                                  1)
                                                          : null,
                                                ),
                                              );
                                            },
                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 12),

                        // Center Name
                        Text(
                          info.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grayWhite,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Info Cards - Using separate cards for each piece of information
                  // Address Card
                  _buildInfoCard(
                    icon: Icons.location_on,
                    iconColor: Colors.white,
                    title: "Address",
                    content: info.address,
                    delay: 100,
                  ),

                  const SizedBox(height: 20),

                  // Email Card
                  _buildInfoCard(
                    icon: Icons.email,
                    iconColor: Colors.white,
                    title: "Email",
                    content: info.email,
                    delay: 200,
                  ),

                  const SizedBox(height: 20),

                  // Phone Card
                  _buildInfoCard(
                    icon: Icons.phone,
                    iconColor: Colors.white,
                    title: "Phone Number",
                    content: info.phoneNumber,
                    delay: 300,
                  ),

                  const SizedBox(height: 20),

                  // Description Card
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: Duration(milliseconds: 400),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                          255,
                          139,
                          102,
                          158,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "About Us",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              info.description,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.grayWhite,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Edit Profile Button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        child: InkWell(
                          onTap: () async {
                            context.read<AuthBloc>().add(
                              AuthLogOutEvent(),
                            );

                            // context.read<CenterGeneralBloc>().add(
                            //   ResetCenterEvent(),
                            // );
                            // context.read<CenterCoursesBloc>().add(
                            //   CenterLogOutCoursesPartEvent(),
                            // );
                            // context.read<CenterRequestsBloc>().add(
                            //   CenterLogOutRequestsPartEvent(),
                            // );
                            // context.read<CenterTrainerBloc>().add(
                            //   CenterLogOutTrainerPartEvent(),
                            // );
                            await DependencyManager.resetDependencies();
                            RestartWidget.restartApp(context);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SplashPage(),
                              ),
                              (route) => false,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                255,
                                139,
                                102,
                                158,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.exit_to_app,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Sign Out",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: Duration(milliseconds: 500),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => EditCenterProfilePage(
                                      centerInfo: info,
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                255,
                                139,
                                102,
                                158,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Add some bottom padding to ensure space between content and bottom nav bar
                  const SizedBox(height: 16),
                ],
              ),
            );
          } else if (state is CenterGeneralExceptionState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.red.shade700,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<CenterGeneralBloc>().add(
                          GetCenterInfoEvent(
                            centerId: widget.centerId,
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text("Try Again"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CenterGeneralInitial ||
              state is CenterGeneralCreatedState) {
            context.read<CenterGeneralBloc>().add(
              GetCenterInfoEvent(centerId: widget.centerId),
            );

            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Fetching center info...",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Fetching center info... Unknown state: $state",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Helper method to build info cards
  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
    required int delay,
  }) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: delay),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 139, 102, 158),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Icon(icon, size: 22, color: iconColor),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.silverGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build information items
  Widget _buildInfoItem(
    IconData icon,
    Color iconColor,
    String title,
    String value,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(icon, size: 22, color: iconColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJoinRequestsPage() {
    return BlocBuilder<CenterRequestsBloc, CenterRequestsState>(
      builder: (context, state) {
        print("---------------------***** state in requests $state");
        // Trigger event once when widget is built
        if (state is CenterRequestsInitial) {
          context.read<CenterRequestsBloc>().add(
            GetCenterRequestsEvent(centerId: widget.centerId),
          );
          return const Center(child: Text("wait please...."));
        }

        if (state is CenterRequestsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CenterRequestsDoneState) {
          final requests = state.requests;

          if (requests.isEmpty) {
            return Column(
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 650),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      children: [
                        SizedBox(height: 55),
                        const Text(
                          "Center Dashboard",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Check Requests",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          "Review and Approve student requests",
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color.fromARGB(
                              255,
                              219,
                              217,
                              217,
                            ),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: const Center(
                    child: Text(
                      "No join requests found.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 139, 102, 158),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 650),
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        children: [
                          SizedBox(height: 55),
                          const Text(
                            "Center Dashboard",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Check Requests",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            "Review and approve student requests",
                            style: TextStyle(
                              fontSize: 19,
                              color: const Color.fromARGB(
                                255,
                                219,
                                217,
                                217,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder:
                          (_, __) => const SizedBox(height: 14),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        return FadeInUp(
                          duration: Duration(
                            milliseconds: 300 + index * 90,
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // 🔹 Purple background tail with "+" button
                              Positioned(
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Container(
                                    width: 80,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(
                                        255,
                                        139,
                                        102,
                                        158,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        bottomRight: Radius.circular(
                                          25,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          context
                                              .read<
                                                CenterRequestsBloc
                                              >()
                                              .add(
                                                ApproveJoinRequestEvent(
                                                  requestMap: request,
                                                ),
                                              );
                                        },
                                        borderRadius:
                                            BorderRadius.circular(30),
                                        child: Container(
                                          padding:
                                              const EdgeInsets.all(2),
                                          decoration:
                                              const BoxDecoration(
                                                color: Colors.white,
                                                shape:
                                                    BoxShape.circle,
                                              ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Color.fromARGB(
                                              255,
                                              139,
                                              102,
                                              158,
                                            ),
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // 🔹 Main white card content
                              Container(
                                margin: const EdgeInsets.only(
                                  right: 75,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    16,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                        0.1,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(
                                          255,
                                          139,
                                          102,
                                          158,
                                        ).withOpacity(0.2),
                                    radius: 24,
                                    child: const Icon(
                                      Icons.person,
                                      color: Color.fromARGB(
                                        255,
                                        139,
                                        102,
                                        158,
                                      ),
                                      size: 26,
                                    ),
                                  ),
                                  title: Text(
                                    request['studentName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Color.fromARGB(
                                        255,
                                        85,
                                        38,
                                        104,
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Requested to join : ${request['courseName']}",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is CenterRequestsExceptionState) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  // Widget _buildJoinRequestsPage() {
  //   final dummyRequests = [
  //     {
  //       "studentName": "Alice Johnson",
  //       "courseTitle": "Flutter Development",
  //     },
  //     {"studentName": "Bob Smith", "courseTitle": "Advanced Java"},
  //   ];

  //   return FadeIn(
  //     duration: const Duration(milliseconds: 500),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           FadeInDown(
  //             duration: const Duration(milliseconds: 650),
  //             child: Card(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18),
  //               ),
  //               elevation: 8,
  //               color: AppColors.gold.withOpacity(0.14),
  //               shadowColor: AppColors.brown.withOpacity(0.17),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(22.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       "Join Requests",
  //                       style: TextStyle(
  //                         fontSize: 25,
  //                         fontWeight: FontWeight.bold,
  //                         color: AppColors.brown,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 7),
  //                     Text(
  //                       "Review and approve student requests.",
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         color: AppColors.mediumGray,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 22),
  //           Expanded(
  //             //! requests in center
  //             child: ListView.separated(
  //               separatorBuilder:
  //                   (_, __) => const SizedBox(height: 14),
  //               itemCount: dummyRequests.length,
  //               itemBuilder: (context, index) {
  //                 final request = dummyRequests[index];
  //                 return FadeInUp(
  //                   duration: Duration(
  //                     milliseconds: 300 + index * 90,
  //                   ),
  //                   child: Card(
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(14),
  //                     ),
  //                     elevation: 6,
  //                     color: Colors.white,
  //                     shadowColor: AppColors.taupe.withOpacity(0.16),
  //                     child: ListTile(
  //                       leading: CircleAvatar(
  //                         backgroundColor: AppColors.taupe
  //                             .withOpacity(0.14),
  //                         radius: 24,
  //                         child: const Icon(
  //                           Icons.person,
  //                           color: AppColors.bronze,
  //                           size: 26,
  //                         ),
  //                       ),
  //                       title: Text(
  //                         request["studentName"]!,
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 18,
  //                           color: AppColors.brown,
  //                         ),
  //                       ),
  //                       subtitle: Text(
  //                         "Requested to join: ${request["courseTitle"]}",
  //                         style: TextStyle(
  //                           color: AppColors.mediumGray,
  //                         ),
  //                       ),
  //                       trailing: ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: AppColors.gold,
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8),
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           // Approve action placeholder
  //                         },
  //                         child: const Text(
  //                           "Approve",
  //                           style: TextStyle(
  //                             color: AppColors.bronze,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildChatChannelPage() {
  //   return FadeIn(
  //     duration: const Duration(milliseconds: 520),
  //     child: Center(
  //       child: Card(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         elevation: 6,
  //         color: const Color(0xFFF7EEDD),
  //         shadowColor: AppColors.bronze.withOpacity(0.14),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(
  //             horizontal: 36,
  //             vertical: 35,
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const Icon(
  //                 Icons.chat,
  //                 size: 55,
  //                 color: AppColors.softBrown,
  //               ),
  //               const SizedBox(height: 15),
  //               Text(
  //                 "Chat Channel",
  //                 style: TextStyle(
  //                   fontSize: 23,
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColors.brown,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTrainersPage() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 650),
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: [
                  SizedBox(height: 55),
                  const Text(
                    "Center Dashboard",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Add A Trainer",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "Manage your trainers effeicently!",
                    style: TextStyle(
                      fontSize: 19,
                      color: const Color.fromARGB(255, 219, 217, 217),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              CircleAvatar(
                radius: 20,
                backgroundColor: Color.fromARGB(255, 139, 102, 158),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => AddTrainerPage(
                              centerId: widget.centerId,
                            ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<CenterTrainerBloc, CenterTrainerState>(
              builder: (context, state) {
                if (state is CenterGotTrainersState) {
                  final currentTrainers = state.trainers;
                  widget.availableTrainers = state.trainers;
                  if (currentTrainers.isEmpty) {
                    return Center(
                      child: Text(
                        "no trainers has been added for now !",
                        style: TextStyle(
                          color: Color.fromARGB(255, 139, 102, 158),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.zero,

                      itemCount: currentTrainers.length,
                      itemBuilder:
                          (context, index) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                      0.4,
                                    ), // soft black blur
                                    blurRadius: 6,
                                    offset: const Offset(
                                      2,
                                      4,
                                    ), // slight shadow offset
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                                //new purple color
                                color: const Color.fromARGB(
                                  255,
                                  139,
                                  102,
                                  158,
                                ),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(25),
                                      child: Image.asset(
                                        'assets/images/grad_logo2.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    currentTrainers[index].name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.grayWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    );
                  }
                } else if (state is CenterTrainerExceptionState) {
                  return Center(child: Text(state.message));
                } else {
                  context.read<CenterTrainerBloc>().add(
                    FetchCenterTrainers(centerId: widget.centerId),
                  );
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text(
                          "state now in trainer in center dashboard is ${state}",
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
// ! older code
/*

// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:grad_project_ver_1/core/colors/app_color.dart';
import 'package:grad_project_ver_1/core/splash_page.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:grad_project_ver_1/features/auth/presintation/bloc/auth_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_courses_bloc/center_courses_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_general_bloc/center_general_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_requests_bloc/center_requests_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/blocs/center_trainer_bloc/center_state.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/add_course_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/add_trainer_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/center_course_details_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/presentation/pages/edit_center_profil_page.dart';
import 'package:grad_project_ver_1/features/clean_you_can/trainer/domain/entities/trainer_entity.dart';

class CenterDashboard extends StatefulWidget {
  final String centerId;
  late List<TrainerEntity> availableTrainers;
  CenterDashboard({super.key, required this.centerId});

  @override
  _CenterDashboardState createState() => _CenterDashboardState();
}

class _CenterDashboardState extends State<CenterDashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    //!get the center from the firestore
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔹 Background Image (covers whole screen)
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_final.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // 🔹 Foreground (Scaffold on top of image)
        Scaffold(
          backgroundColor: Colors.transparent, // keep transparent

          appBar: AppBar(
            title: FadeInDown(
              duration: const Duration(milliseconds: 700),
              child: const Text(
                "Center Dashboard",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightGray,
                  fontSize: 22,
                ),
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent, // transparent appbar
            iconTheme: const IconThemeData(color: AppColors.brown),
          ),

          body: IndexedStack(
            index: _selectedIndex,
            children: [
              _buildCoursesPage(),
              _buildJoinRequestsPage(),
              _buildTrainersPage(),
              _buildProfilePage(),
            ],
          ),

          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor:
                  Colors.transparent, // 👈 force transparency
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent, // 👈 extra safety
              elevation: 0,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Courses',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pending_actions),
                  label: 'Requests',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt_outlined),
                  label: 'Trainers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.bronze,
              unselectedItemColor: AppColors.silverGray,
              onTap: _onItemTapped,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          floatingActionButton:
              _selectedIndex == 1 || _selectedIndex == 3
                  ? null
                  : FadeIn(
                    duration: const Duration(milliseconds: 420),
                    child: FloatingActionButton(
                      backgroundColor: AppColors.bronze,
                      elevation: 7,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    _selectedIndex == 0
                                        ? AddCoursePage(
                                          centerId: widget.centerId,
                                          availableTrainers:
                                              widget
                                                  .availableTrainers,
                                        )
                                        : AddTrainerPage(
                                          centerId: widget.centerId,
                                        ),
                          ),
                        );
                      },
                      child: Icon(
                        _selectedIndex == 0
                            ? Icons.add
                            : Icons.person_add_alt_1_outlined,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ],
    );
  }

  //! done Scaffold**********************************************************************
  Widget _buildCoursesPage() {
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 650),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 8,
                color: AppColors.gold.withOpacity(0.14),
                shadowColor: AppColors.brown.withOpacity(0.17),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Courses",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.lightGold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        "Manage your courses efficiently!",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.warmGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: BlocBuilder<
                CenterCoursesBloc,
                CenterCoursesState
              >(
                builder: (context, state) {
                  if (state is CenterGotCoursesState) {
                    if (state.courses.isEmpty) {
                      return Center(
                        child: FadeInUp(
                          child: Text(
                            "There are no courses yet.",
                            style: TextStyle(
                              color: AppColors.bronze,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      separatorBuilder:
                          (_, __) => const SizedBox(height: 14),
                      itemCount: state.courses.length,
                      itemBuilder:
                          (context, index) => FadeInUp(
                            duration: Duration(
                              milliseconds: 300 + index * 90,
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  14,
                                ),
                              ),
                              color: Colors.transparent,
                              elevation: 6,
                              shadowColor: AppColors.taupe
                                  .withOpacity(0.16),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.taupe
                                      .withOpacity(0.14),
                                  radius: 24,
                                  child: const Icon(
                                    Icons.school,
                                    color: AppColors.bronze,
                                    size: 29,
                                  ),
                                ),
                                title: Text(
                                  state.courses[index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: AppColors.lightGold,
                                  ),
                                ),
                                subtitle: Text(
                                  state.courses[index].description,
                                  style: TextStyle(
                                    color: AppColors.warmGray,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.gold.withOpacity(
                                      0.18,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "${state.courses[index].price}\$",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.goldLight,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (
                                            context,
                                          ) => CourseDetailsForCenter(
                                            course:
                                                state.courses[index],
                                            trainers:
                                                widget
                                                    .availableTrainers,
                                            isForTrainer: false,
                                          ),
                                      // CourseDetailsPage(
                                      //   course:
                                      //       state.courses[index],
                                      //   isStudent: false,
                                      //   trainers:
                                      //       widget
                                      //           .availableTrainers,
                                      // ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                    );
                  } else if (state is CenterCoursesExceptionState) {
                    return FadeIn(
                      duration: const Duration(milliseconds: 350),
                      child: Center(
                        child: Text(
                          state.message.toString(),
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else {
                    context.read<CenterCoursesBloc>().add(
                      GetCenterCoursesEvent(
                        centerId: widget.centerId,
                      ),
                    );
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePage() {
    return FadeIn(
      duration: const Duration(milliseconds: 520),
      child: BlocBuilder<CenterGeneralBloc, CenterGeneralState>(
        builder: (context, state) {
          if (state is CenterGeneralLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.deepPurple,
                ),
              ),
            );
          } else if (state is CenterGeneralGotInfoState) {
            final info = state.centerInfo;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                children: [
                  // Profile Card with more compact design
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Background circle
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurple.withOpacity(
                                  0.1,
                                ),
                              ),
                            ),

                            // Avatar icon
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                      0.08,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 42,
                                backgroundColor: Colors.deepPurple
                                    .withOpacity(0.2),
                                child: ClipOval(
                                  child:
                                      info.imageUrl == null
                                          ? Image.asset(
                                            'assets/images/grad_logo.png',
                                            width: 84,
                                            height: 84,
                                            fit: BoxFit.cover,
                                          )
                                          : Image.network(
                                            info.imageUrl!,
                                            width: 84,
                                            height: 84,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) => Image.asset(
                                                  'assets/images/grad_logo.png',
                                                  width: 84,
                                                  height: 84,
                                                  fit: BoxFit.cover,
                                                ),
                                            loadingBuilder: (
                                              context,
                                              child,
                                              loadingProgress,
                                            ) {
                                              if (loadingProgress ==
                                                  null)
                                                return child;
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value:
                                                      loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              (loadingProgress.expectedTotalBytes ??
                                                                  1)
                                                          : null,
                                                ),
                                              );
                                            },
                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Center Name
                        Text(
                          info.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grayWhite,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Info Cards - Using separate cards for each piece of information
                  // Address Card
                  _buildInfoCard(
                    icon: Icons.location_on,
                    iconColor: Colors.redAccent.shade400,
                    title: "Address",
                    content: info.address,
                    delay: 100,
                  ),

                  const SizedBox(height: 10),

                  // Email Card
                  _buildInfoCard(
                    icon: Icons.email,
                    iconColor: Colors.blue.shade700,
                    title: "Email",
                    content: info.email,
                    delay: 200,
                  ),

                  const SizedBox(height: 10),

                  // Phone Card
                  _buildInfoCard(
                    icon: Icons.phone,
                    iconColor: Colors.green.shade600,
                    title: "Phone Number",
                    content: info.phoneNumber,
                    delay: 300,
                  ),

                  const SizedBox(height: 12),

                  // Description Card
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: Duration(milliseconds: 400),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 18,
                                color: AppColors.lightGold,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "About Us",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lightGold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            info.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.grayWhite,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Edit Profile Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FadeInUp(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthLogOutEvent(),
                            );
                            context.read<CenterGeneralBloc>().add(
                              ResetCenterEvent(),
                            );
                            context.read<CenterCoursesBloc>().add(
                              CenterLogOutCoursesPartEvent(),
                            );
                            context.read<CenterRequestsBloc>().add(
                              CenterLogOutRequestsPartEvent(),
                            );
                            context.read<CenterTrainerBloc>().add(
                              CenterLogOutTrainerPartEvent(),
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SplashPage(),
                              ),
                              (route) => false,
                            );
                          },
                          icon: const Icon(
                            Icons.exit_to_app,
                            size: 20,
                          ),
                          label: const Text("Sign out"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            shadowColor: Colors.deepPurple
                                .withOpacity(0.3),
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: Duration(milliseconds: 500),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => EditCenterProfilePage(
                                      centerInfo: info,
                                    ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit, size: 20),
                          label: const Text("Edit Profile"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.glowingOrange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            shadowColor: Colors.deepPurple
                                .withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Add some bottom padding to ensure space between content and bottom nav bar
                  const SizedBox(height: 16),
                ],
              ),
            );
          } else if (state is CenterGeneralExceptionState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.red.shade700,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<CenterGeneralBloc>().add(
                          GetCenterInfoEvent(
                            centerId: widget.centerId,
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text("Try Again"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CenterGeneralInitial ||
              state is CenterGeneralCreatedState) {
            context.read<CenterGeneralBloc>().add(
              GetCenterInfoEvent(centerId: widget.centerId),
            );

            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Fetching center info...",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Fetching center info... Unknown state: $state",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Helper method to build info cards
  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
    required int delay,
  }) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: delay),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 22, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightGold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.silverGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build information items
  Widget _buildInfoItem(
    IconData icon,
    Color iconColor,
    String title,
    String value,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(icon, size: 22, color: iconColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJoinRequestsPage() {
    return BlocBuilder<CenterRequestsBloc, CenterRequestsState>(
      builder: (context, state) {
        print("---------------------***** state in requests $state");
        // Trigger event once when widget is built
        if (state is CenterRequestsInitial) {
          context.read<CenterRequestsBloc>().add(
            GetCenterRequestsEvent(centerId: widget.centerId),
          );
          return const Center(child: Text("wait please...."));
        }

        if (state is CenterRequestsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CenterRequestsDoneState) {
          final requests = state.requests;

          if (requests.isEmpty) {
            return const Center(
              child: Text(
                "No join requests found.",
                style: TextStyle(color: AppColors.warmGray),
              ),
            );
          }

          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 650),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 8,
                      color: AppColors.gold.withOpacity(0.14),
                      shadowColor: AppColors.brown.withOpacity(0.17),
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Check Requests",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: AppColors.brown,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              "Review and approve student requests.",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.mediumGray,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder:
                          (_, __) => const SizedBox(height: 14),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        return FadeInUp(
                          duration: Duration(
                            milliseconds: 300 + index * 90,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 6,
                            color: Colors.white,
                            shadowColor: AppColors.taupe.withOpacity(
                              0.16,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.taupe
                                    .withOpacity(0.14),
                                radius: 24,
                                child: const Icon(
                                  Icons.person,
                                  color: AppColors.bronze,
                                  size: 26,
                                ),
                              ),
                              title: Text(
                                request['studentName'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.brown,
                                ),
                              ),
                              subtitle: Text(
                                "Requested to join: ${request['courseName']}",
                                style: TextStyle(
                                  color: AppColors.mediumGray,
                                ),
                              ),
                              trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.gold,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<CenterRequestsBloc>()
                                      .add(
                                        ApproveJoinRequestEvent(
                                          requestMap: request,
                                        ),
                                      );
                                },
                                child: const Text(
                                  "Approve",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is CenterRequestsExceptionState) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  // Widget _buildJoinRequestsPage() {
  //   final dummyRequests = [
  //     {
  //       "studentName": "Alice Johnson",
  //       "courseTitle": "Flutter Development",
  //     },
  //     {"studentName": "Bob Smith", "courseTitle": "Advanced Java"},
  //   ];

  //   return FadeIn(
  //     duration: const Duration(milliseconds: 500),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           FadeInDown(
  //             duration: const Duration(milliseconds: 650),
  //             child: Card(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(18),
  //               ),
  //               elevation: 8,
  //               color: AppColors.gold.withOpacity(0.14),
  //               shadowColor: AppColors.brown.withOpacity(0.17),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(22.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       "Join Requests",
  //                       style: TextStyle(
  //                         fontSize: 25,
  //                         fontWeight: FontWeight.bold,
  //                         color: AppColors.brown,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 7),
  //                     Text(
  //                       "Review and approve student requests.",
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         color: AppColors.mediumGray,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 22),
  //           Expanded(
  //             //! requests in center
  //             child: ListView.separated(
  //               separatorBuilder:
  //                   (_, __) => const SizedBox(height: 14),
  //               itemCount: dummyRequests.length,
  //               itemBuilder: (context, index) {
  //                 final request = dummyRequests[index];
  //                 return FadeInUp(
  //                   duration: Duration(
  //                     milliseconds: 300 + index * 90,
  //                   ),
  //                   child: Card(
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(14),
  //                     ),
  //                     elevation: 6,
  //                     color: Colors.white,
  //                     shadowColor: AppColors.taupe.withOpacity(0.16),
  //                     child: ListTile(
  //                       leading: CircleAvatar(
  //                         backgroundColor: AppColors.taupe
  //                             .withOpacity(0.14),
  //                         radius: 24,
  //                         child: const Icon(
  //                           Icons.person,
  //                           color: AppColors.bronze,
  //                           size: 26,
  //                         ),
  //                       ),
  //                       title: Text(
  //                         request["studentName"]!,
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 18,
  //                           color: AppColors.brown,
  //                         ),
  //                       ),
  //                       subtitle: Text(
  //                         "Requested to join: ${request["courseTitle"]}",
  //                         style: TextStyle(
  //                           color: AppColors.mediumGray,
  //                         ),
  //                       ),
  //                       trailing: ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: AppColors.gold,
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8),
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           // Approve action placeholder
  //                         },
  //                         child: const Text(
  //                           "Approve",
  //                           style: TextStyle(
  //                             color: AppColors.bronze,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildChatChannelPage() {
  //   return FadeIn(
  //     duration: const Duration(milliseconds: 520),
  //     child: Center(
  //       child: Card(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         elevation: 6,
  //         color: const Color(0xFFF7EEDD),
  //         shadowColor: AppColors.bronze.withOpacity(0.14),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(
  //             horizontal: 36,
  //             vertical: 35,
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const Icon(
  //                 Icons.chat,
  //                 size: 55,
  //                 color: AppColors.softBrown,
  //               ),
  //               const SizedBox(height: 15),
  //               Text(
  //                 "Chat Channel",
  //                 style: TextStyle(
  //                   fontSize: 23,
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColors.brown,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTrainersPage() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 650),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            AddTrainerPage(centerId: widget.centerId),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 8,
                color: AppColors.gold.withOpacity(0.14),
                shadowColor: AppColors.brown.withOpacity(0.17),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add a Trainer",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.lightGold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        "Manage your trainers efficiently!",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.warmGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<CenterTrainerBloc, CenterTrainerState>(
              builder: (context, state) {
                if (state is CenterGotTrainersState) {
                  final currentTrainers = state.trainers;
                  widget.availableTrainers = state.trainers;
                  if (currentTrainers.isEmpty) {
                    return Center(
                      child: Text(
                        "no trainers has been added for now !",
                        style: TextStyle(color: AppColors.lightGray),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: currentTrainers.length,
                      itemBuilder:
                          (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.white.withOpacity(0.1),
                              elevation: 6,
                              shadowColor: AppColors.taupe
                                  .withOpacity(0.16),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/images/grad_logo2.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  currentTrainers[index].name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.grayWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    );
                  }
                } else if (state is CenterTrainerExceptionState) {
                  return Center(child: Text(state.message));
                } else {
                  context.read<CenterTrainerBloc>().add(
                    FetchCenterTrainers(centerId: widget.centerId),
                  );
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text(
                          "state now in trainer in center dashboard is ${state}",
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


 */