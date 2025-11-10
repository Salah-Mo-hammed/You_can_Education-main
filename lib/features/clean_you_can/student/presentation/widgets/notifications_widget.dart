import 'package:flutter/material.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/common_widgets.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CommonWidgets().buildHeaderText(
            "Notifications",
            true,
          ),
        ),
        SliverToBoxAdapter(
          child: _buildNotificationsText(
            Icons.calendar_today_outlined,
            Colors.blue,
            "Course starting soon",
            "please complete the assiagnmets",
            false,
            "Yesterday",
          ),
        ),
        SliverToBoxAdapter(
          child: _buildNotificationsText(
            Icons.messenger_outline,
            Colors.green,
            "message from instructor",
            "your certificates for prof skills",
            false,
            "Sun",
          ),
        ),
        SliverToBoxAdapter(
          child: _buildNotificationsText(
            Icons.done_outline,
            Colors.yellow[800]!,
            "Certificates Available",
            "your :web dev course  starts tomorrow at 10:00 AM",
            true,
            "15 April",
          ),
        ),
      ],
    );
  }



  Widget _buildNotificationsText(
    IconData icon,
    Color iconColor,
    String text,
    String subText,
    bool haveseen,
    String timing,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: haveseen ? Colors.white : Colors.blue.withOpacity(.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 25),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      text,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(subText),
                    Text(timing),
                  ],
                ),
              ],
            ),
            if (!haveseen)
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  bottom: 30.0,
                ),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.blue,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
