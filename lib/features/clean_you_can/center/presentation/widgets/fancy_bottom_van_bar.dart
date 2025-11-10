import 'package:flutter/material.dart';

class FancyBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const FancyBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.book,
      Icons.pending_actions,
      Icons.people_alt_outlined,
      Icons.person,
    ];

    final labels = ["Courses", "Requests", "Trainers", "Profile"];

    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 139, 102, 158),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              transform: Matrix4.translationValues(
                0,
                isSelected ? -12 : 0,
                0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isSelected ? 50 : 40,
                    width: isSelected ? 50 : 40,
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Colors.white
                              : Colors.transparent,
                      shape: BoxShape.circle,
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                    0.25,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                              : [],
                    ),
                    child: Icon(
                      icons[index],
                      color:
                          isSelected
                              ? const Color.fromARGB(
                                255,
                                139,
                                102,
                                158,
                              )
                              : Colors.white,
                      size: isSelected ? 26 : 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labels[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight:
                          isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
